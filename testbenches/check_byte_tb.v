module check_tb();


reg [7:0] data_in;
// reg [1:0] tlp_or_dllp_in;
reg valid,DK;
wire [1:0]tlp_out;
wire [2:0]type;
check_byte dut (
       .data_in(data_in),
       .tlp_or_dllp_in(tlp_out), 
       .valid(valid),
       .DK(DK),
        .type(type),
    .tlp_or_dllp_out(tlp_out) 
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



initial 
begin

DK=0; valid = 0;data_in = 0;
#10
DK=1; valid = 1;data_in = STP;
#10
DK=0;valid = 1;data_in = 6;
#10
DK=0;valid = 1;data_in = 7;
#10
DK=0;valid = 1;data_in = 8;
#50
DK=0;valid = 1;data_in = 9;
#10
DK=1;valid = 1;data_in = END;
#10

DK=0;valid = 1;data_in = 10;
#10
DK=1;valid = 0;data_in = STP;
#10
$stop();

end








endmodule