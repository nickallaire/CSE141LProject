module reg_data_mux(
	input	[5:0] immed,
	input	[7:0] mem,
	input	[7:0] alu,
	input	[7:0] accum,
	input	[1:0] data,
	output	[7:0] writeData
	);

	case(data)
		2'b00: writeData = {2'b00, immed};
		2'b01: writeData = mem;
		2'b10: writeData = alu;
		2'b11: writeData = accum;
	endcase

endmodule