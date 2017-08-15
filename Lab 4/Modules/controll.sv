module controll(
	input  [2:0] opcode, func,
	output logic [2:0] aluOp,
	output logic [1:0] data,
	output logic regDst, beq, blt, mem, rWrite, mWrite, mRead, halt, clr, regOut
	);
	
always_comb begin
	case(opcode)
		3'b000: begin
			case(func)
				3'b000: begin // halt
					aluOp = 3'b111;
					data = 2'b00;
					regDst = 0;
					beq = 0;
					blt = 0;
					mem = 0;
					rWrite = 0;
					mWrite = 0;
					mRead = 0;
					halt = 1;
					clr = 0;
					regOut = 0;
				end
				3'b001: begin // lw
					aluOp = 3'b111;
					data = 2'b01;
					regDst = 1;
					beq = 0;
					blt = 0;
					mem = 0;
					rWrite = 1;
					mWrite = 0;
					mRead = 1;
					halt = 0;
					clr = 0;
					regOut = 1;
				end
				3'b010: begin // sw
					aluOp = 3'b111;
					data = 2'b00;
					regDst = 0;
					beq = 0;
					blt = 0;
					mem = 0;
					rWrite = 0;
					mWrite = 1;
					mRead = 0;
					halt = 0;
					clr = 0;
					regOut = 1;
				end
				3'b011: begin // add
					aluOp = 3'b000;
					data = 2'b10;
					regDst = 0;
					beq = 0;
					blt = 0;
					mem = 0;
					rWrite = 1;
					mWrite = 0;
					mRead = 0;
					halt = 0;
					clr = 0;
					regOut = 1;
				end
				3'b100: begin  // comp
					aluOp = 3'b000;
					data = 2'b10;
					regDst = 1;
					beq = 0;
					blt = 0;
					mem = 0;
					rWrite = 1;
					mWrite = 0;
					mRead = 0;
					halt = 0;
					clr = 0;
					regOut = 0;
				end
				3'b101: begin // mov
					aluOp = 3'b111;
					data = 2'b11;
					regDst = 1;
					beq = 0;
					blt = 0;
					mem = 0;
					rWrite = 1;
					mWrite = 0;
					mRead = 0;
					halt = 0;
					clr = 0;
					regOut = 0;
				end
				3'b110: begin // j
					aluOp = 3'b111;
					data = 2'b00;
					regDst = 0;
					beq = 1;
					blt = 1;
					mem = 1;
					rWrite = 0;
					mWrite = 0;
					mRead = 1;
					halt = 0;
					clr = 0;
					regOut = 1;
				end
				3'b111: begin // clr
					aluOp = 3'b111;
					data = 2'b00;
					regDst = 0;
					beq = 0;
					blt = 0;
					mem = 0;
					rWrite = 0;
					mWrite = 0;
					mRead = 0;
					halt = 0;
					clr = 1;
					regOut = 0;
				end
			endcase
		end
		3'b001: begin // blt
			aluOp = 3'b111;
			data = 2'b00;
			regDst = 0;
			beq = 0;
			blt = 1;
			mem = 1;
			rWrite = 0;
			mWrite = 0;
			mRead = 1;
			halt = 0;
			clr = 0;
			regOut = 0;
		end
		3'b010: begin // beq
			aluOp = 3'b111;
			data = 2'b00;
			regDst = 0;
			beq = 1;
			blt = 0;
			mem = 1;
			rWrite = 0;
			mWrite = 0;
			mRead = 1;
			halt = 0;
			clr = 0;
			regOut = 0;
		end
		3'b011: begin // sl
			aluOp = 3'b011;
			data = 2'b10;
			regDst = 1;
			beq = 0;
			blt = 0;
			mem = 0;
			rWrite = 1;
			mWrite = 0;
			mRead = 0;
			halt = 0;
			clr = 0;
			regOut = 0;
		end
		3'b100: begin // sr
			aluOp = 3'b100;
			data = 2'b10;
			regDst = 1;
			beq = 0;
			blt = 0;
			mem = 0;
			rWrite = 1;
			mWrite = 0;
			mRead = 0;
			halt = 0;
			clr = 0;
			regOut = 0;
		end
		3'b101: begin // sro
			aluOp = 3'b101;
			data = 2'b10;
			regDst = 1;
			beq = 0;
			blt = 0;
			mem = 0;
			rWrite = 1;
			mWrite = 0;
			mRead = 0;
			halt = 0;
			clr = 0;
			regOut = 0;
		end
		3'b110: begin // set
			aluOp = 3'b111;
			data = 2'b00;
			regDst = 0;
			beq = 0;
			blt = 0;
			mem = 0;
			rWrite = 1;
			mWrite = 0;
			mRead = 0;
			halt = 0;
			clr = 0;
			regOut = 1;
		end
		3'b111: begin // sti
			aluOp = 3'b111;
			data = 2'b00;
			regDst = 1;
			beq = 0;
			blt = 0;
			mem = 0;
			rWrite = 1;
			mWrite = 0;
			mRead = 0;
			halt = 0;
			clr = 0;
			regOut = 0;
		end
	endcase
end
endmodule
	