module Gen_3_check_byte(
    input   [7:0]data_in,
    input   [4:0]tlp_or_dllp_in, 
    input   valid,
    input   [1:0]SyncHeader,

    output  [5:0]type,
    output  [4:0]tlp_or_dllp_out
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

// types
    localparam data       = 6'b100_000;
    localparam  not_valid = 6'b000_000;
    localparam tlpstart   = 6'b010_000;
    localparam tlpend     = 6'b001_000;
    localparam dllpend    = 6'b000_100;
    localparam dllpstart  = 6'b000_010;
    localparam tlpedb     = 6'b000_001;
// 
    localparam not_valid_data = 5'b00000 ;
    localparam tlp_byte1 = 5'b00001;
    localparam tlp_byte2 = 5'b00010;
    localparam tlp_byte3 = 5'b00011;
    localparam tlp_byte4 = 5'b00100;
    
    
    localparam dllp_byte1 = 5'b00101;
    localparam dllp_byte2 = 5'b10110;
    localparam dllp_byte3 = 5'b00110;
    localparam dllp_byte4 = 5'b01001;
    
    localparam dllpend_byte1 = 5'b01000;
    localparam dllpend_byte2 = 5'b01011;
    localparam dllpend_byte3 = 5'b01010;
    localparam dllpend_byte4 = 5'b11001;
    

    localparam tlpend_byte1 = 5'b01100;
    localparam tlpend_byte2 = 5'b01111;
    localparam tlpend_byte3 = 5'b01110;
    localparam tlpend_byte4 = 5'b10101;
    
    localparam tlpedb_byte1 = 5'b10000;
    localparam tlpedb_byte2 = 5'b10011;
    localparam tlpedb_byte3 = 5'b10010;
    localparam tlpedb_byte4 = 5'b10001;
    
    
    localparam valid_data_tlp = 5'b10100 ;
    localparam valid_data_dllp = 5'b11100 ;
   
    reg[5:0] type_reg;    
    reg [4:0]tlp_or_dllp_out_reg;

    reg [4:0]tlp_or_dllp_in_reg;

    always @*
    begin
       tlp_or_dllp_out_reg=tlp_or_dllp_in;
        // type_reg=not_valid;  
        if(valid)begin
            if(SyncHeader == k)
            begin
              case (data_in)
            SDP_byte1:begin
                tlp_or_dllp_out_reg = dllp_byte1;     
            end 
            SDP_byte2:
                if(tlp_or_dllp_in == dllp_byte1)begin
                    tlp_or_dllp_out_reg = valid_data_dllp;  
                    type_reg = dllpstart;
                end
            END_byte1:begin
                if (tlp_or_dllp_in == valid_data_dllp)
                    begin
                        tlp_or_dllp_out_reg = dllpend_byte1;
                        
                    end
                   
                 if (tlp_or_dllp_in == valid_data_tlp) begin
                    tlp_or_dllp_out_reg = tlpend_byte1;
                       
                 end
                end    
            END_byte2:begin
                if (tlp_or_dllp_in == dllpend_byte1)
                    begin
                        tlp_or_dllp_out_reg = dllpend_byte2;
                        
                    end
                   
                else if (tlp_or_dllp_in == tlpend_byte1) begin
                    tlp_or_dllp_out_reg = tlpend_byte2;
                       
                 end
                else if (tlp_or_dllp_in == dllpend_byte3)
                    begin
                        tlp_or_dllp_out_reg = not_valid_data;
                        type_reg = dllpend;
                        
                    end
                   
                else if (tlp_or_dllp_in == tlpend_byte3) begin
                   
                        type_reg = tlpend;   
                 end
                end    
            END_byte3:begin
                if (tlp_or_dllp_in == dllpend_byte2)
                    begin
                        tlp_or_dllp_out_reg = dllpend_byte3;
                        
                    end
                   
                 if (tlp_or_dllp_in == tlpend_byte2) begin
                    tlp_or_dllp_out_reg = tlpend_byte3;
                       
                 end
                end    
            // END_byte4:begin
            //     if (tlp_or_dllp_in == dllpend_byte3)
            //         begin
            //             tlp_or_dllp_out_reg = not_valid_data;
            //             type_reg = dllpend;
                        
            //         end
                   
            //      if (tlp_or_dllp_in == tlpend_byte3) begin
                   
            //             tlp_or_dllp_out_reg = not_valid_data;
            //             type_reg = tlpend;   
            //      end
            //     end    
                               
        


            EDB_byte1: begin
                if(tlp_or_dllp_in == valid_data_tlp)
                begin
                tlp_or_dllp_out_reg =  tlpedb_byte1; 
                end
            end
            EDB_byte2:
                if(tlp_or_dllp_in == tlpedb_byte1)
                begin
                tlp_or_dllp_out_reg =  tlpedb_byte2; 
                end              
        
            
            EDB_byte3:
                if(tlp_or_dllp_in == tlpedb_byte2)
                begin
                tlp_or_dllp_out_reg =  tlpedb_byte3; 
                end              
                else if(tlp_or_dllp_in == tlpedb_byte3)
                begin
        
                tlp_or_dllp_out_reg = not_valid_data;
                type_reg = tlpend;    
                end
            //   {STP,4'b????}:begin
            //         tlp_or_dllp_out_reg = valid_data_tlp;  
            //         type_reg = tlpstart;
            //     end
            default: type_reg = not_valid;
              endcase  
            end
            else 
            begin
              if(tlp_or_dllp_in != not_valid_data)begin 
               type_reg=data;
              end 
              else
               begin
                   type_reg=not_valid;
              end  
            end
        end
        else 
        begin
            type_reg=not_valid;    
        end
    end

assign type = type_reg;
assign tlp_or_dllp_out = tlp_or_dllp_out_reg;

endmodule

