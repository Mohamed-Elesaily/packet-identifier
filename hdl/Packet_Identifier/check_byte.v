module check_byte(
    input   [7:0]data_in,
    input   [1:0]tlp_or_dllp_in, 
    input   valid,
    input   DK,

    output  [2:0]type,
    output  [1:0]tlp_or_dllp_out 
    
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
    reg [1:0]tlp_or_dllp_out_reg;

    reg [1:0]tlp_or_dllp_in_reg;

    always @*
    begin
       tlp_or_dllp_out_reg=tlp_or_dllp_in;
       
        if(valid)begin
            if(DK)
            begin
              case (data_in)
            SDP:begin
                tlp_or_dllp_out_reg = dllp;
                type_reg = dllpstart;

                
            end 
            STP:begin
                    tlp_or_dllp_out_reg = tlp;  
                    type_reg = tlpstart;
                end
        
            END:begin
                if (tlp_or_dllp_in == dllp)
                    begin
                        tlp_or_dllp_out_reg = not_valid_data;
                        type_reg = dllpend;
                    end
                 if (tlp_or_dllp_in == tlp) begin
                    tlp_or_dllp_out_reg = not_valid_data;
                    type_reg = tlpend;     
                 end
                end    
            
           
            EDB: begin
                type_reg = tlpedb ;
                tlp_or_dllp_out_reg = not_valid_data;
                end             
        
            PAD:type_reg = not_valid; 
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

