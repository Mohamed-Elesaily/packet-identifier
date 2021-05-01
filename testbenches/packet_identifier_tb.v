module packet_identifier_tb();

reg [511:0]Data_in;
reg hld_pd;
reg rst;
reg clk;

wire [511:0]Data_out;
wire [64*3 -1:0]ByteType;
wire w;
reg[63:0]valid;
localparam p1 = 64'hFB_1234_FD_5C_12_FD_12;
MacLayer mac(


     .Data_in(Data_in),
     .hld_pd(hld_pd),
     .rst(rst),
     .clk(clk),

     .Data_out(Data_out),
     .ByteType(ByteType),
     .w(w),
     .valid(valid)
);

initial begin
    valid = 64'hFFFF_FFFF_FFFF_FFFF;
    hld_pd = 0;
    rst =0; clk= 0;
    
    Data_in = p1;
    #100
    valid = 64'h0;
    #100
    $stop;
end












endmodule