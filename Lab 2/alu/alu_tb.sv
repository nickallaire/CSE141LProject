module alu_tb;
	// DUT Input Drivers
   	bit [2:0]    OP;
   	bit [3:0]    CI;
   	bit [7:0]    INPUTA;
   	bit [7:0]    INPUTB;

	// DUT Outputs
	wire [7:0]  OUT;
	wire [3:0]  CO;
	wire 		EQUAL;
	wire 		LESSTHAN;

	// Instantiate the Unit Under Test (UUT)
	alu uut(
	  //.clk(clk), 
	  .OP(OP),
	  .CI(CI),
	  .INPUTA(INPUTA),
	  .INPUTB(INPUTB),
	  .OUT(OUT),
	  .CO(CO),
	  .EQUAL(EQUAL),
	  .LESSTHAN(LESSTHAN)
	);

	//assign op_mne = mne'(RegWrite);

	initial begin
	// Initialize Inputs done for us by "bit"

	// Wait 100 ns for global reset to finish
	#100ns;

	// Check if add works without CI and no OV
	INPUTA = 'h3;
	INPUTB = 'h9;
	CI = 4'b0000;
	OP =
	#20ns;

	// Check if add works with CI and no OV
	INPUTA = 'h4;
	INPUTB = 'h8;
	CI = 4'b0001;
	#20ns;

	// Check if add (ADD) works without CI and OV
	INPUTA = 'hff;
	INPUTB = 'h1;
	CI = 4'b0000;
	#20ns;

	// Check if add (ADD) works with CI and OV
	INPUTA = 'hff;
	INPUTB = 'h1;
	CI = 4'b0001;
	#20ns;

	// Check if comp (COMP) works on positive numbers
	INPUTA = 'h5;
	#20ns;

	// Check if comp (COMP) works on negative numbers
	INPUTA = -'h5; // not sure if this will work
	#20ns;

	// Check if shift right (SR) works
	INPUTA = 'b01101001;
	INPUTB = 'h3;
	#20ns;

	// Check if shift right pad with overflow = 1 (SRO) works
	INPUTA = 'b10110010;
	INPUTB = 'h4;
	#20ns;

	// Check if shift right pad with overflow = 0 (SRO) works
	INPUTA = 'b10110010;
	INPUTB = 'h4;
	#20ns;

	// Check if shift left (SL) works
	INPUTA = 'b00101101;
	INPUTB = 'h2;

	#20ns $stop;
	end 

endmodule