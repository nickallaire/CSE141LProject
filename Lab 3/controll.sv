module control(
	input  [2:0] opcode, func,
	output [2:0] aluOp,
	output [1:0]33z data,
	output 		 regDst, beq, blt, mem, rWrite, mWrite, mRead, halt, clr
	);
	
	case(opcode)
		3'b000: begin
			case(func)
				3'b000: begin // halt
					aluOP = 3'b111;
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
				end
				3'b001: begin // lw
					aluOP = 3'b111;
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
				end
				3'b010: begin // sw
					aluOP = 3'b111;
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
				end
				3'b011: begin // add
					aluOP = 3'b001;
					data = 2'b010;
					regDst = 0;
					beq = 0;
					blt = 0;
					mem = 0;
					rWrite = 1;
					mWrite = 0;
					mRead = 0;
					halt = 0;
					clr = 0;
				end
				3'b100: begin  // comp
					aluOP = 3'b000;
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
				end
				3'b101: begin // mov
					aluOP = 3'b111;
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
				end
				3'b110: begin // j
					aluOP = 3'b111;
					data = 2'b00;
					regDst = 0;
					beq = 1;
					blt = 0;
					mem = 1;
					rWrite = 0;
					mWrite = 0;
					mRead = 0;
					halt = 0;
					clr = 0;
				end
				3'b111: begin // clr
					aluOP = 3'b111;
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
				end
			endcase
		end
		3'b001: begin // blt
			aluOP = 3'b111;
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
		end
		3'b010: begin // beq
			aluOP = 3'b111;
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
		end
		3'b011: begin // sl
			aluOP = 3'b010;
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
		end
		3'b100: begin // sr
			aluOP = 3'b011;
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
		end
		3'b101: begin // sro
			aluOP = 3'b100;
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
		end
		3'b110: begin // set
			aluOP = 3'b111;
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
		end
		3'b111: begin // sti
			aluOP = 3'b111;
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
		end
	endcase
	
endmodule
	