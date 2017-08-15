module reg_dst_mux(
	input	[2:0] raddrA,
	input	[2:0] accumReg,
	input	regDst,
	output	logic [2:0] writeAddr
	);
	always_comb begin
		case(regDst)
			0: writeAddr = accumReg;
			1: writeAddr = raddrA;
			default: writeAddr = 3'b000;
		endcase
	end
endmodule