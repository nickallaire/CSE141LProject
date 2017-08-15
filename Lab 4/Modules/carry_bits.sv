module carry_bits(
	input  [3:0] co,
	input  clr,
	input  CLK,
	output logic [3:0] ci
);

logic [3:0] core;

always_comb begin
	ci = core;
end

always_ff @ (posedge CLK)
	if(clr) begin
		core = 0;
	end
	else begin
		core = co;
	end
endmodule