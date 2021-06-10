module Gen_3_check_byte_tb;
reg [7:0]data,data2;
reg valid;
reg [1:0]syncHeader;
reg rst;
reg clk;
wire [11:0]byte_count,byte_count2,byte_count3;
wire [2:0]byteheader,byteheader2,byteheader3;
wire [11:0]count_limit,count_limit2,count_limit3;
wire [5:0]type,type2;

localparam SDP_byte1 = 8'b1111_0000;
localparam SDP_byte2 = 8'b0101_0011 ;
localparam STP = 4'b1111 ;

initial begin
   clk=0; rst = 0;valid = 1; data = 0; data2=0;#10 rst=1;syncHeader = 2'b01;
    // #10 rst=1;syncHeader = 2'b01;
    // data = SDP_byte1; data2 = SDP_byte2;
    // #10 data = 0;data2 = 1;
    // #10 data = 2;data2 = 3;
    // #10 data = 4;data2 = 5;
    // #10 data = 1;data2 = 3;
    data = {4'd8,STP}; data2 = 0;
    #10 data = 0;data2 = 1;
    #10 data = 2;data2 = 3;
    #10 data = 4;data2 = 5;
    #10 data = 1;data2 = 3;
    #10 data =  8'b1100_0000;
    #50
$stop();


end


Gen_3_check_byte dut(
    .data_in        (data) ,
    .valid          (valid)  ,   
    .byte_count_in  (byte_count3) ,
    .byte_header_in  (byteheader3) ,
    .count_limit_in (count_limit3),         
    .type           (type)         ,
    .byte_count_out (byte_count2),
    .byte_header_out(byteheader2)  ,       
    .count_limit_out(count_limit2)       


);
Gen_3_check_byte dut2(
    .data_in        (data2) ,
    .valid          (valid),
    .byte_count_in  (byte_count2),
    .byte_header_in  (byteheader2),
    .count_limit_in (count_limit2) ,
    .type           (type2)        ,
    .byte_count_out (byte_count)  ,
    .byte_header_out(byteheader)  ,
    .count_limit_out(count_limit)       


);

reg_check dut3(
 .clk(clk),
 .rst(rst),
 .data_in({byte_count,byteheader,count_limit}),
 .data_out({byte_count3,byteheader3,count_limit3})
);
always 
   #5 clk = ~clk;
endmodule