/*Write RTL code for designing a 10bit SIPO right shift register such that:
 
a. Serial input “din” is shifted at 1250MHZ (system clock) frequency. 
b. The 10-bit parallel output “dout” will be latched only at a clock frequency of 
125MHZ(derived clock).
c. The clock is an active high signal with an active low synchronous reset.
d. P.S: There is only one synchronous clock domain.*/

module SIPO(input clk_1250Mhrz , rst ,input din, output reg [9:0] dout);

//internal shift register

reg [9:0] shift_reg;
//The clock is an active high signal with an active low synchronous reset

always@(posedge clk_1250Mhrz or negedge rst)
begin 
if(!rst)
	dout <= 10'b0;

//Serial input “din” is shifted at 1250MHZ (system clock) frequency.

else 
	shift_reg <= {din,shift_reg[9:1]};
end

//125MHZ(derived clock).

reg clk_125MHZ ;
reg [3:0] count; 
//MOD 10 counter

always@(posedge clk_1250Mhrz)
begin 
	if(!rst)
		begin
				count <= 4'b0;
				clk_125MHZ<=1'b0;
		end
	else if(count ==  4'd9) begin
				count <= 4'b0; 
				end
	else begin
				count <= count+1'b1; end
end

//frequncy logic 
always@(count)
begin
	if(count == 0)
	clk_125MHZ <= ~clk_125MHZ;
end

//The 10-bit parallel output “dout” will be latched only at a clock frequency of 
//125MHZ(derived clock).

always@(posedge clk_125MHZ or negedge rst)
begin 
	if(!rst)
		dout <= 10'd0;
	else
		dout <= shift_reg;
end

endmodule