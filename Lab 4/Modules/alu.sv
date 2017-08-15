// Create Date:    18:04:22 10/27/2011 
// Design Name: 
// Module Name:    ALU 
// Project Name: 
//
// Dependencies: 
//
// Revision: 		  2017.02.25
// Revision 0.01 - File Created
// Additional Comments: 
//
// combinational (unclocked) unsigned ALU w/ carry-in and carry-out

import definitions::*;			        // includes package "definitions"

module alu(
  input        [ 2:0] OP,		   	    // ALU opcode, part of microcode
  input        [ 2:0] FUNC,         // Add or comp
  input        [ 3:0] CI,           // shift or carry in from right (LSB side)
  input        [ 7:0] INPUTA,	   	  // data inputs
                      INPUTB,
  output logic [ 7:0] OUT,		      // or:  output reg [ 7:0] OUT,
  output logic [ 3:0] CO,           // shift or carry out to left (MSB side)
  output logic        ZERO,			    // 1: OUT = 0
                      EQUAL,			  // 1: INPUTA = INPUTB
							        LESSTHAN      // 1: INPUTA < INPUTB
  );
	 
  assign EQUAL = (INPUTA == INPUTB) ? 1'b1 : 1'b0;	 // are inputs equal?
  assign LESSTHAN = (INPUTA < INPUTB) ? 1'b1 : 1'b0;

  op_mne op_mnemonic;			  		  // type enum: used for convenient waveform viewing

  int temp;
  assign temp = {4'b0, CI};
  logic[11:0] shift = 0;
  logic[11:0] add = 0;

  always_comb begin
	case(OP)
    kAorC   : begin
      if(FUNC == 3'b011) begin
        //{CO,OUT} = {3'b0, INPUTA+INPUTB+CI};
        add = INPUTA + INPUTB + CI;
        CO = add[11:8];
        OUT = add[7:0];
      end
      else if(FUNC == 3'b100)
        {CO,OUT} = {CI,-INPUTA};
      else
        {CO,OUT} = {CI, INPUTA};
    end
	  kSR     : {CO,OUT} = INPUTA >> INPUTB;				// bitwise and: CO = 0 due to Verilog rules
	  kSRO    : {CO,OUT}	= (INPUTA >> INPUTB) | (temp << (8-INPUTB));
	  kSL     : begin //{CO,OUT} = INPUTA << INPUTB;
      shift = INPUTA << INPUTB;
      CO = shift[11:8];
      OUT = shift[7:0];
    end
	  default : {CO,OUT} = {CI, INPUTA};
	endcase

	case(OUT)
	  8'b0    : ZERO = 1'b1;
	  default : ZERO = 1'b0;
	endcase

  //$display("ALU Out %d \n",OUT);
  op_mnemonic = op_mne'(OP);

  end

endmodule
