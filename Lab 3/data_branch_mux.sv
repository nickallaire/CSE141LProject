module data_branch_mux(
	input	[7:0] accum,
	//input	[7:0] const,
	input	mem,
	output	[7:0] data_addr
	);

	int const = 200;

	case(mem)
		1'b0: data_addr = accum;
		1'b1: data_addr = accum + const;
	endcase

endmodule