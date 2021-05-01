module Gen_ctrl
 #(
    parameter GEN1_PIPEWIDTH = 8 ,	
	parameter GEN2_PIPEWIDTH = 16 ,	
	parameter GEN3_PIPEWIDTH = 32 ,								
	parameter GEN4_PIPEWIDTH = 8 ,	
	parameter GEN5_PIPEWIDTH = 8 
)(
    
    input hld_pd_gen,
    input [2:0]gen,
    input rst,
    input clk,
    output sel,
    output [63:0]valid,
    output w

);

localparam gen1_sel = 3'b000;
localparam gen2_sel = 3'b001;
localparam gen3_sel = 3'b010;
localparam gen4_sel = 3'b011;
localparam gen5_sel = 3'b100;


localparam N = 64;
// reg [2:0]gen1 = GEN1_PIPEWIDTH/8;
// reg [2:0]gen2 = GEN2_PIPEWIDTH/8;
// reg [2:0]gen3 = GEN3_PIPEWIDTH/8;
// reg [2:0]gen4 = GEN4_PIPEWIDTH/8;
// reg [2:0]gen5 = GEN5_PIPEWIDTH/8;

reg [63:0]valid_reg;

reg state, state_next;
reg w_reg;
integer valid_i=0;
// gen decoder
always @*
begin
    case (gen)
    gen1_sel: 
    for(valid_i=0;valid_i<N;valid_i=valid_i+1)
    begin
        if(valid_i<(GEN1_PIPEWIDTH*16)/8) valid_reg[valid_i] = 1'b1;
        else valid_reg[valid_i] = 1'b0;
    end

    gen2_sel: 
    for(valid_i=0;valid_i<N;valid_i=valid_i+1)
    begin
        if(valid_i<(GEN2_PIPEWIDTH*16)/8) valid_reg[valid_i] = 1'b1;
        else valid_reg[valid_i] = 1'b0;
    end

    gen3_sel: 
    for(valid_i=0;valid_i<N;valid_i=valid_i+1)
    begin
        if(valid_i<(GEN3_PIPEWIDTH*16)/8) valid_reg[valid_i] = 1'b1;
        else valid_reg[valid_i] = 1'b0;
    end

    gen4_sel: 
    for(valid_i=0;valid_i<N;valid_i=valid_i+1)
    begin
        if(valid_i<(GEN4_PIPEWIDTH*16)/8) valid_reg[valid_i] = 1'b1;
        else valid_reg[valid_i] = 1'b0;
    end

    gen5_sel: 
    for(valid_i=0;valid_i<N;valid_i=valid_i+1)
    begin
        if(valid_i<(GEN5_PIPEWIDTH*16)/8) valid_reg[valid_i] = 1'b1;
        else valid_reg[valid_i] = 1'b0;
    end

    default:
    for(valid_i=0;valid_i<N;valid_i=valid_i+1)
    begin
        if(valid_i<(GEN1_PIPEWIDTH*16)/8) valid_reg[valid_i] = 1'b1;
        else valid_reg[valid_i] = 1'b0;
    end

        
    endcase
end

localparam s0 = 1'b0;

localparam s1 = 1'b1;


always @(posedge clk or negedge rst) begin
    if(~rst)
    begin 
        state <= s0;
    end
    else 
    begin
        state <= state_next;     
    end
end  

always @* 
begin
    case (state)
       s0: if(~hld_pd_gen)begin
        state_next = s1;
        w_reg = 1;
     end
     else begin
        state_next = s0;
        w_reg = 0; 
     end
        s1:if(hld_pd_gen)begin
        state_next = s0;
        w_reg = 0;
     end
     else begin
        state_next = s1;
        w_reg = 1; 
     end
    default:state_next = s0;
    endcase
     

     
end
assign sel = 1'b0;
assign w = w_reg;
assign valid = valid_reg;  
endmodule