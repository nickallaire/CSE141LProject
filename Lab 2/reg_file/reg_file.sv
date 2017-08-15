// Create Date:    2017.01.25
// Design Name: 
// Module Name:    reg_file 
//
// Additional Comments: 					  $clog2

module reg_file (
  input           clk,
                  write_en,
  input  [2:0]    raddrA,
                  raddrB,
                  waddr,
  input  [7:0]    data_in,
  output logic [7:0] data_outA,
  output logic [7:0] data_outB,
  output logic [7:0] accum
    );
 	 
	// 16 registers
	logic [7:0] registers[15:0];
	accum = registers[0];

// access different registers based on reg index
always_comb begin
	case(registers[1])

		1: begin
			data_outA = registers[raddrA + 6];
			data_outB = registers[raddrB + 6];
		end
		2: begin
			data_outA = registers[raddrA + 12];
			data_outB = registers[raddrB + 12];
		end
		default: begin
			data_outA = registers[raddrA];
			data_outB = registers[raddrB];
		end
	endcase

	if(raddrA < 2) begin
		data_outA = registers[raddrA];
	end

	if(raddrB < 2) begin
		data_outB = registers[raddrB];
	end
end

// sequential (clocked) writes
always_ff @ (posedge clk)
  if (write_en)
  	case (core[1])
  		1: begin
  			if (waddr == 3'b000 || waddr == 3'b001)
    			core[waddr] <= data_in;
    		else
    			core[waddr + 6] <= data_in;
    	end
    	2: begin
  			if (waddr == 3'b000 || waddr == 3'b001)
    			core[waddr] <= data_in;
    		else
    			core[waddr + 12] <= data_in;
    	end
    	default: core[waddr] <= data_in;
    endcase

endmodule
