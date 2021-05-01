module pd_register(
    input [511:0]data_in,
    input [63:0]DK_in,
    
    input clk,
    input rst,
    input  hld_pd,
    output [511:0]data_out,
    output [63:0]DK_out,
    output hld_out
);
localparam s0 = 1'b0;
localparam s1 = 1'b1;
reg [511:0]data_next,data_reg;
reg [63:0]DK_next,DK_reg;

always @(posedge clk) begin
    if(~rst)
    begin
    data_reg <=0;
     DK_reg <=0;
    end
    else 
    begin
        data_reg <= data_next;
        DK_reg <= DK_next;
    end

end

always @*
 begin
      if(~hld_pd)begin
        DK_next = DK_in;
        data_next = data_in;
     end
     else begin
        data_next = data_reg;
        DK_next = DK_reg;
     end

end

assign hld_out = hld_pd;
assign data_out = data_reg;
assign DK_out = DK_reg;
endmodule