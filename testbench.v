module SIPO_tb;

reg clk_1250Mhrz , rst ,din;
wire [9:0] dout;

SIPO dut(clk_1250Mhrz , rst ,din, dout);

//clk 1250 Mhrz generation

initial 
begin 
clk_1250Mhrz = 1'b0;
forever #4 clk_1250Mhrz = ~clk_1250Mhrz;
end

//reset logic 

task resets;
begin
@(negedge clk_1250Mhrz) 
rst = 1'b0; #40;
@(negedge clk_1250Mhrz)
rst =1'b1;
end 
endtask

//input logic 
integer i;

task inputs();
begin 
for(i=0;i<5'd20;i=i+1) 
@(negedge clk_1250Mhrz)
din = i[1:0];
end
endtask

initial
begin 
resets;
inputs;
#600 $finish;
end

endmodule 

