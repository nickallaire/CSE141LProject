module data_branch_mux(
	input	[7:0] accum,
	//input	[7:0] const,
	input	mem,
	output	logic [7:0] data_addr
	);

	int constant = 135;

always_comb begin
	case(mem)
		1'b0: data_addr = accum;
		1'b1: data_addr = accum + constant;
	endcase
end
endmodule