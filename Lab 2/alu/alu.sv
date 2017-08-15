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
  input        [ 3:0] CI,           // shift or carry in from right (LSB side)
  input        [ 7:0] INPUTA,	   	  // data inputs
                      INPUTB,
  output logic [ 7:0] OUT,		      // or:  output reg [ 7:0] OUT,
  output logic [ 3:0] CO,           // shift or carry out to left (MSB side)
  output              ZERO,			    // 1: OUT = 0
                      EQUAL,			  // 1: INPUTA = INPUTB
							        LESSTHAN      // 1: INPUTA < INPUTB
  );
	 
  assign EQUAL = (INPUTA == INPUTB) ? 1'b1 : 1'b0;	 // are inputs equal?
  assign LESSTHAN = (INPUTA < INPUTB) ? 1'b1 : 1'b0;

  op_mne op_mnemonic;			  		  // type enum: used for convenient waveform viewing

  int temp;
  assign temp = {4'b0, CI};

  always_comb begin
	case(OP)
	  kADD    : {CO,OUT} = {3'b0, INPUTA+INPUTB+CI}
    kCOMP   : {CO,OUT} = {CI,-INPUTA};
	  kSR     : {CO,OUT} = INPUTA >> INPUTB;				// bitwise and: CO = 0 due to Verilog rules
	  kSRO    : {CO,OUT}	= (INPUTA >> INPUTB) | (temp << (8-INPUTB));
	  kSL     : {CO,OUT} = INPUTA << INPUTB;
	  default : {CO,OUT} = 12'b0;
	endcase

	case(OUT)
	  8'b0    : ZERO = 1'b1;
	  default : ZERO = 1'b0;
	endcase

  //$display("ALU Out %d \n",OUT);
  op_mnemonic = op_mne'(OP);

  end

endmodule
