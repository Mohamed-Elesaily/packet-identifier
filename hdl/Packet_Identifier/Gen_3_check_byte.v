
module Gen_3_check_byte(
    input   [7:0]data_in,
    input   valid,
    input   [11:0]byte_count_in,
    input   [1:0]byte_header_in,
    input   [11:0]count_limit_in,
   
    input clk,
    input rst,
	  output   [5:0]type,
    output   [11:0]byte_count_out,
    output   [1:0]byte_header_out,
    output   [11:0]count_limit_out
                
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
    
    // byte type
    localparam sdp1 = 2'b01;
    localparam sdp2 = 2'b10;
// types
    localparam data       = 6'b100_000;
    localparam not_valid  = 6'b000_000;
    localparam tlpstart   = 6'b010_000;
    localparam tlpend     = 6'b001_000;
    localparam dllpend    = 6'b000_100;
    localparam dllpstart  = 6'b000_010;
    localparam tlpedb     = 6'b000_001;

reg   [11:0]byte_count_in_reg;
reg   [1:0]byte_header_in_reg;
reg   [11:0]count_limit_in_reg;
reg   [5:0]type_reg;

always @(posedge clk) begin
    byte_count_in_reg = byte_count_in;
    byte_header_in_reg = byte_header_in;
    count_limit_in_reg = count_limit_in;
    type_reg = not_valid;
    if(valid)
    begin
        if(data_in == SDP_byte1)
        begin
            byte_header_in_reg = sdp1;
        end
        else if ((data_in == SDP_byte2) & (byte_header_in == sdp1) ) 
        begin
            // count = 0
            count_limit_in_reg = 12'd8;
            byte_count_in_reg = 12'd0;
            // type SDP
            type_reg = dllpstart;
            byte_header_in_reg = sdp2;
            // 
        end
        else if((byte_count_in < count_limit_in) && (byte_header_in == sdp2))
        begin
            
            byte_count_in_reg = byte_count_in_reg + 1;
            type_reg = data;
        end
        else if((byte_count_in == 8) & (byte_header_in == sdp2))
        begin

            count_limit_in_reg = 0;
            byte_count_in_reg = 0;
            byte_header_in_reg = 0;
            type_reg = dllpend;

        end    
    end
  
    
end


assign byte_count_out = byte_count_in_reg;
assign byte_header_out = byte_header_in_reg;
assign count_limit_out = count_limit_in_reg;
assign type = type_reg;

endmodule
