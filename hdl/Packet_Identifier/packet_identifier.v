module MacLayer #(
    parameter GEN1_PIPEWIDTH = 8 ,	
	parameter GEN2_PIPEWIDTH = 8 ,	

	parameter GEN3_PIPEWIDTH = 8 ,	

								
	parameter GEN4_PIPEWIDTH = 8 ,	
	parameter GEN5_PIPEWIDTH =8
)(

input [511:0]data_in,
input hld_pd,
input rst,
input clk,
input [2:0]gen,
input [63:0]DK,
output [511:0] data_out,
output [191:0] bytetype,
output w

);
wire hld;
wire sel;
wire [63:0]valid;
wire [511:0]data;
wire [511:0]data_sel1;
wire [511:0]data_sel2;
wire [191:0] bytetype_sel1;
wire [63:0]DK_in;
wire [191:0] bytetype_sel2;


pd_register pd_reg(
    .data_in(data_in),
    .clk(clk),
    .rst(rst),
    .DK_in(DK),
    .DK_out(DK_in),
    .hld_pd(hld_pd),
    .data_out(data),
    .hld_out(hld)
);

Gen1_2_DataPath gen1_2_db(
    .Data_in(data),
    .DK(DK_in),
    .valid(valid),
    .Data_out(data_sel1),
    .ByteType(bytetype_sel1)
	 
);


Gen_ctrl #(
     .GEN1_PIPEWIDTH(8),	
	 .GEN2_PIPEWIDTH(8),	
	 .GEN3_PIPEWIDTH(8),								
	 .GEN4_PIPEWIDTH(8),	
	 .GEN5_PIPEWIDTH(8)
) gen_ctrl(
    
    .hld_pd_gen(hld),
    .gen(gen),
    .rst(rst),
    .clk(clk),
    .sel(sel),
    .valid(valid),
    .w(w)

);



Gen_mux gen_mux(
    .data_in1(data_sel1),
    .data_in2(data_sel2),
    .bytetype1(bytetype1),
    .bytetype2(bytetype2),
    .sel(sel),
    .data_out(data_out),
    .ByteType(bytetype)
);

endmodule

