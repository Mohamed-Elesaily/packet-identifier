module GenDataPath3_tb();
reg [511:0]data_in;
reg [63:0]valid;

wire [511:0]data_out;

wire [63:0]dlpstart1; 
wire [63:0]dlpend1  ; 
wire [63:0]tlpstart1; 
wire [63:0]tlpedb1  ; 
wire [63:0]tlpend1  ; 
wire [63:0]valid_d;
reg clk,rst;
reg [127:0]syncHeader;
Gen3_DataPath DUT(
    .Data_in(data_in),
    .syncHeader(syncHeader),
    .valid(valid),
    .clk(clk),
    .Data_out(data_out),
    .dlpstart (dlpstart1),
    .dlpend   (dlpend1  ),
    .tlpstart (tlpstart1),
    .tlpedb   (tlpedb1  ),
    .tlpend   (tlpend1  ),
    .valid_d  (valid_d)  ,
    .rst(rst)
);
// data boundries
localparam SDP_byte1 = 8'b1111_0000;
localparam SDP_byte2 = 8'b0101_0011 ;
localparam STP = 4'b1111 ;
// types


    reg  hhh;
    integer i=0;
initial begin
  rst = 0;
  valid = 0;
  data_in=0;
  clk = 0;  
  syncHeader = 0;
  hhh=1;
  #10
rst = 1;

// for(i =0;i<512;i = i+ 1)begin
// data_in[i] = 0;
// end
// data_in = {4'd2,STP};
data_in = {SDP_byte2,SDP_byte1};
for(i =0;i<128;i = i+ 1)begin
    hhh = ~hhh;
syncHeader[i] = hhh;
end
for(i =0;i<64;i = i+ 1)begin
   valid[i] = 1; 
end
// data_in[7:0] = {4'd15,STP}; 
    #50
$stop();

end

always 
   #5 clk = ~clk;

endmodule