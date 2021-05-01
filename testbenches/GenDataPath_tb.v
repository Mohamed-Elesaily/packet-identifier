module GenDataPath_tb();
reg [511:0]data_in;
reg [63:0]DK;
reg [63:0]valid;
wire [511:0]data_out;
wire [64*3 -1:0]ByteType;
GenDataPath DUT(
    .Data_in(data_in),
    .DK(DK),
    .valid(valid),
    .Data_out(data_out),
    .ByteType(ByteType)

);
// data boundries
    localparam STP = 8'b111_11011 ;
    localparam SDP = 8'b010_11100 ;
    localparam END = 8'b111_11101 ;
    localparam EDB = 8'b111_11110 ;
    localparam PAD = 8'b111_10111;

// types
    localparam data = 3'b000;
    localparam  not_valid = 3'b111;
    localparam tlpstart = 3'b001 ;
    localparam tlpend = 3'b010 ;
    localparam dllpend = 3'b100 ;
    localparam dllpstart = 3'b011 ;
    localparam tlpedb = 3'b101 ;
// 
    localparam tlp = 2'b01;
    localparam dllp = 2'b10;
    localparam not_valid_data = 2'b00 ;
   
    reg[2:0] type_reg;    
    reg [1:0]tlp_or_dllp_reg;


initial begin

  DK    = 0;
  valid = 0;
  data_in=0;
  #10
   DK    =64'hc0_00000000000000;
  valid = 64'hffff_ffff_ffff_ffff;
  data_in=64'hFB_1234_5674_1234_FD;
  #10
$stop();

end

endmodule