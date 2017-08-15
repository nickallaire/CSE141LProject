module carry_bits(
	input  [3:0] co,
	input  clr,
	output [3:0] ci
);
always comb_begin
	if (clr) begin
		ci = 4'b0000;
	end
	else begin
		ci = co;
	end
end

endmodule