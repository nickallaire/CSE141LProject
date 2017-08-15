module division_tb;

bit  signed [15:0] dividend;
bit  signed [ 7:0] divisor;
wire signed [15:0] quotient_beh;
logic signed [15:0] quotient_DUT;
bit          clk, start;
wire         done;
bit  [  7:0] score;            // how many correct trials

// be sure to substitute the name of your top_level module here
// also, substitute names of your ports, as needed
top_level DUT(
  .start (start),
  .CLK   (clk),
  .haltProgram  (done)
  );

// behavioral model to match
divison DUT1(
	dividend,divisor,quotient_beh
   );

initial begin
  #10ns  start = 1'b1;
  #10ns for (int i=0; i<256; i++)		 // clear data memory
	      DUT.data_mem.core[i] = 8'b0;
// you may preload any desired constants into your data_mem here
//    ...
// case 1

  dividend = 16'h1000;
  divisor = 8'h10;
  DUT.data_mem.core[128] = 8'h10;
  DUT.data_mem.core[129] = 8'h00;
  DUT.data_mem.core[130] = 8'h10;

  // Branch LUT Labels
  DUT.data_mem.core[157] = 8'd15;
  DUT.data_mem.core[158] = 8'd46;
  DUT.data_mem.core[159] = 8'd80;
  DUT.data_mem.core[160] = 8'd88;
  DUT.data_mem.core[161] = 8'd36;
  DUT.data_mem.core[162] = 8'd42;

// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
	DUT.reg_file.core[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("division_instr.txt",DUT.instr_rom.core);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  quotient_DUT = {DUT.data_mem.core[126],DUT.data_mem.core[127]};
  #10ns  $display(quotient_beh,quotient_DUT);
  if(quotient_beh == quotient_DUT)	 // score another successful trial
    score++;


// case 2
  #10ns  start = 1'b1;
  #10ns dividend = 16'h7FFF;
  divisor = 8'h7F;
  DUT.data_mem.core[128] = dividend[15:8];
  DUT.data_mem.core[129] = dividend[ 7:0];
  DUT.data_mem.core[130] = divisor;
  DUT.data_mem.core[126] = 0;
  DUT.data_mem.core[127] = 0;


  // Branch LUT Labels
  DUT.data_mem.core[157] = 8'd15;
  DUT.data_mem.core[158] = 8'd46;
  DUT.data_mem.core[159] = 8'd80;
  DUT.data_mem.core[160] = 8'd88;
  DUT.data_mem.core[161] = 8'd36;
  DUT.data_mem.core[162] = 8'd42;


// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
	DUT.reg_file.core[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("division_instr.txt",DUT.instr_rom.core);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  quotient_DUT = {DUT.data_mem.core[126],DUT.data_mem.core[127]};
  #10ns  $display(quotient_beh,quotient_DUT);
  if(quotient_beh == quotient_DUT)	 // score another successful trial
    score++;

// case 3
  #10ns  start = 1'b1;
  #10ns dividend = 16'h6F;
  divisor = 8'h70;
  DUT.data_mem.core[128] = dividend[15:8];
  DUT.data_mem.core[129] = dividend[ 7:0];
  DUT.data_mem.core[130] = divisor;

    // Branch LUT Labels
  DUT.data_mem.core[157] = 8'd15;
  DUT.data_mem.core[158] = 8'd46;
  DUT.data_mem.core[159] = 8'd80;
  DUT.data_mem.core[160] = 8'd88;
  DUT.data_mem.core[161] = 8'd36;
  DUT.data_mem.core[162] = 8'd42;

// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
	DUT.reg_file.core[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("division_instr.txt",DUT.instr_rom.core);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  quotient_DUT = {DUT.data_mem.core[126],DUT.data_mem.core[127]};
  #10ns  $display(quotient_beh,quotient_DUT);
  if(quotient_beh == quotient_DUT)	 // score another successful trial
    score++;

// case 4
  #10ns  start = 1'b1;
  #10ns dividend = 16'h100;
  divisor = 8'h10;
  DUT.data_mem.core[128] = dividend[15:8];
  DUT.data_mem.core[129] = dividend[ 7:0];
  DUT.data_mem.core[130] = divisor;

    // Branch LUT Labels
  DUT.data_mem.core[157] = 8'd15;
  DUT.data_mem.core[158] = 8'd46;
  DUT.data_mem.core[159] = 8'd80;
  DUT.data_mem.core[160] = 8'd88;
  DUT.data_mem.core[161] = 8'd36;
  DUT.data_mem.core[162] = 8'd42;

// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
	DUT.reg_file.core[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("division_instr.txt",DUT.instr_rom.core);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  quotient_DUT = {DUT.data_mem.core[126],DUT.data_mem.core[127]};
  #10ns  $display(quotient_beh,quotient_DUT);
  if(quotient_beh == quotient_DUT)	 // score another successful trial
    score++;

// case 5
  #10ns  start = 1'b1;
  #10ns dividend = 16'h5A5A;
  divisor = 8'h78;
  DUT.data_mem.core[128] = dividend[15:8];
  DUT.data_mem.core[129] = dividend[ 7:0];
  DUT.data_mem.core[130] = divisor;

    // Branch LUT Labels
  DUT.data_mem.core[157] = 8'd15;
  DUT.data_mem.core[158] = 8'd46;
  DUT.data_mem.core[159] = 8'd80;
  DUT.data_mem.core[160] = 8'd88;
  DUT.data_mem.core[161] = 8'd36;
  DUT.data_mem.core[162] = 8'd42;

// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
	DUT.reg_file.core[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("division_instr.txt",DUT.instr_rom.core);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  quotient_DUT = {DUT.data_mem.core[126],DUT.data_mem.core[127]};
  #10ns  $display(quotient_beh,quotient_DUT);
  if(quotient_beh == quotient_DUT)	 // score another successful trial
    score++;

	
	#10ns	$stop;
end

always begin
  #5ns  clk = 1'b1;
  #5ns  clk = 1'b0;
end

endmodule
