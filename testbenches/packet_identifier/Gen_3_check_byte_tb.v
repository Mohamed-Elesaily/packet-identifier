module check_tb();


reg [7:0] data_in;
reg valid;
reg [1:0]syncheader;
wire [4:0]tlp_out;
wire [5:0]type;
Gen_3_check_byte dut (
       .data_in(data_in),
       .tlp_or_dllp_in(tlp_out), 
       .valid(valid),
       .SyncHeader(syncheader),
        .type(type),
    .tlp_or_dllp_out(tlp_out) 
);


// data boundries
localparam STP = 4'b1111 ;

    localparam SDP_byte1 = 8'b1111_0000;
    localparam SDP_byte2 = 8'b0101_0011 ;
    
    localparam END_byte1 = 8'b0001_1111 ;
    localparam END_byte2 = 8'b0000_0000 ;
    localparam END_byte3 = 8'b1001_0000 ;
    localparam END_byte4 = 8'b0000_0000 ;
    
    localparam EDB_byte1 = 8'b1100_0000 ;
    localparam EDB_byte2 = 8'b1100_0000 ;
    localparam EDB_byte3 = 8'b111_11110 ;
    localparam EDB_byte4 = 8'b111_11110 ; 
    
    // syncheader
    localparam k= 2'b01;
    localparam d= 2'b10;



initial 
begin

data_in=0;valid=0;syncheader=d;


#10 data_in=0;valid=1;syncheader=d;

#10 data_in=1;syncheader=k;
#10 data_in=1;syncheader=d;


#10 data_in=SDP_byte1;syncheader=k;
#10 data_in=SDP_byte2;syncheader=k;

#10 data_in=1;syncheader=d;
#10 data_in=2;syncheader=d;
#10 data_in=3;syncheader=d;


#10 data_in=END_byte1;syncheader=k;
#10 data_in=END_byte2;syncheader=k;
#10 data_in=END_byte3;syncheader=k;
#10 data_in=END_byte4;syncheader=k;

#10 data_in=2;syncheader=d;
#10 data_in=3;syncheader=d;



#10
$stop();

end








endmodule