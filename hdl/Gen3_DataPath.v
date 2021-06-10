module Gen3_DataPath(
    input [63:0]Data_in,
    input [7:0]valid,
    // output [63:0]Data_out,

    output [7:0]dlpstart ,
    output [7:0]dlpend   ,
    output [7:0]tlpstart ,
    output [7:0]tlpedb   ,
    output [7:0]tlpend   ,
    output [7:0]valid_d
);

integer i = 0;

always @* begin
  for(i=0;i<64;i = i + 8)
  begin
    if(data[i+3:i] == 4'hf)
    begin
      
    end
  end
end



    
endmodule