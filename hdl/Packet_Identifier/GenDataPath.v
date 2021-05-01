
module GenDataPath(
    input [511:0]Data_in,
    input [63:0]DK,
    input [63:0]valid,
    output [511:0]Data_out,
    output [64*3 -1:0]ByteType
   
);

wire [63:0]tlp_or_dllp1;

wire [63:0]tlp_or_dllp2;

localparam N = 64;



assign Data_out = Data_in;

generate
    genvar i;
    for(i=0;i<64;i = i + 1)
        begin  : generate_checkbytes
          if(i == 0)
          begin
            check_byte CheckByte(
                .data_in(Data_in[8*(i+1)-1:8*i]),
                .tlp_or_dllp_in({tlp_or_dllp1[63],tlp_or_dllp2[63]}),
                .valid(valid[i]),
                .DK(DK[i]),
                .type(ByteType[(i+1)*3 -1:i*3]),
                .tlp_or_dllp_out({tlp_or_dllp1[0],tlp_or_dllp2[0]})

            );  
          end
          else if (i == N-1) begin
              check_byte CheckByte(
                .data_in(Data_in[8*(i+1)-1:8*i]),
                .tlp_or_dllp_in({tlp_or_dllp1[62],tlp_or_dllp2[62]}),
                .valid(valid[i]),
                .DK(DK[i]),
                .type(ByteType[(i+1)*3 -1:i*3]),
                .tlp_or_dllp_out({tlp_or_dllp1[63],tlp_or_dllp2[63]})
            );  
          end
          else 
          begin
             check_byte CheckByte(
                .data_in(Data_in[8*(i+1)-1:8*i]),
                .tlp_or_dllp_in({tlp_or_dllp1[i-1],tlp_or_dllp2[i-1]}),
                .valid(valid[i]),
                .DK(DK[i]),
                .type(ByteType[(i+1)*3 -1:i*3]),
                .tlp_or_dllp_out({tlp_or_dllp1[i],tlp_or_dllp2[i]})
            );      
          end  
            


        end
 

endgenerate

endmodule