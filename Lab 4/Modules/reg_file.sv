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
	logic [7:0] core[15:0];


// access different core based on reg index
always_comb begin
	case(core[1])

		1: begin
			data_outA = core[raddrA + 6];
			data_outB = core[raddrB + 6];
		end
		2: begin
			data_outA = core[raddrA + 12];
			data_outB = core[raddrB + 12];
		end
		default: begin
			data_outA = core[raddrA];
			data_outB = core[raddrB];
		end
	endcase

	if(raddrA < 2) begin
		data_outA = core[raddrA];
	end

	if(raddrB < 2) begin
		data_outB = core[raddrB];
	end
	accum = core[0];

	/*
	$display("raddrA: %d, raddrB: %d", raddrA, raddrB);
	$display("Register 0: %d", core[0]);
	$display("Register 1: %d", core[1]);
	$display("Register 2: %d", core[2]);
	$display("Register 3: %d", core[3]);
	$display("Register 4: %d", core[4]);
	$display("Register 5: %d", core[5]);
	$display("Register 6: %d", core[6]);
	$display("Register 7: %d", core[7]);
	$display("Register 8: %d", core[8]);
	$display("Register 9: %d", core[9]);
	$display("Register 10: %d", core[10]);
	*/

end

// sequential (clocked) writes
always_ff @ (posedge clk)
  if (write_en) begin
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
	//$display("Written Register 10: %d", core[10]);
  end
endmodule
