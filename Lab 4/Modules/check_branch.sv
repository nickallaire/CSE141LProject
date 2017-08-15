module check_branch(
	input  [15:0] pc,
	input  [7:0] dataOut,
	input  beq,
		    blt,
		    equal,
		    lessthan,
	output logic [15:0] program_counter,
	output logic branch
);

	wire [15:0] temp = 16'b0;

always_comb begin
	if (beq && blt) begin
		program_counter <= dataOut + temp;
		branch = 1'b1;
	end
	else if (beq && equal) begin
		program_counter <= dataOut + temp;
		branch = 1'b1;
	end
	else if (blt && lessthan) begin
		program_counter <= dataOut + temp;
		branch = 1'b1;
	end
	else begin
		program_counter <= pc;
		branch = 1'b0;
	end
end
endmodule