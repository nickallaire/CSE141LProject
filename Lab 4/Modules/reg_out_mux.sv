module reg_out_mux (
	input [7:0] inputB,
				accum,
	input 		regOut,
	output logic [7:0] data_out
);
	always_comb begin
	    case (regOut)
		    1'b0: data_out = inputB;
		    1'b1: data_out = accum;
	    endcase
      end

endmodule