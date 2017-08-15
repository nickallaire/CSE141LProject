module stringsearch_rev_tb;

bit  [511:0] string1;		   // data_mem[32:95]
bit  [  3:0] sequence1;		   // data_mem[9][3:0]
wire [  7:0] count_beh;
logic[  7:0] count_DUT;
bit          clk, start;
wire         done;
bit  [  7:0] score;            // how many correct trials
// be sure to substitute the name of your top_level module here
// also, substitute names of your ports, as needed
top_level DUT(				   // your top-level Verilog module
  .start (start),
  .CLK   (clk),
  .haltProgram  (done)
  );

// purely behavioral model to match
// its output(s) = benchmark for your design
stringsearch DUT1(
  .string1 ,
  .sequence1,
  .count (count_beh)
   );

initial begin
  #10ns  start = 1'b1;
  #10ns for (int i=0; i<256; i++)		 // clear data memory
	      DUT.data_mem.core[i] = 8'b0;
// you may preload any desired constants into your data_mem here
  // Branch LUT Labels
  DUT.data_mem.core[152] = 8'd18;
  DUT.data_mem.core[153] = 8'd26;
  DUT.data_mem.core[154] = 8'd41;
  DUT.data_mem.core[155] = 8'd61;
  DUT.data_mem.core[156] = 8'd89;
//    ...
// now declare the searchable string and the 4-bit pattern itself
   string1   = {{64{4'b1100}},{64{4'b0001}}};//{{102{5'b01001}},2'b0};//{128{4'b1001}};
   sequence1 = 4'b1001;
// load 4-bit pattern into memory address 9, LSBs
  DUT.data_mem.core[9] = {4'b0,sequence1};  // load "Waldo"
// load string to be searched -- watch Endianness
  for(int i=0; i<64; i++)
    DUT.data_mem.core[95-i] = string1[7+8*i-:8];
// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.reg_file.core[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("string_instr.txt",DUT.instr_rom.core);
//  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  count_DUT = DUT.data_mem.core[10];
  #10ns  $display(count_beh,,,count_DUT);
  #10ns; /*for(int j=32; j<96; j++)
           for(int k=7; k>=0; k--)
             $writeb(DUT.data_mem.core[j][k]);
  #10ns $display();*/
  if(count_beh == count_DUT)	 // score another successful trial
    score++;
  #10ns;
// shall we have another go?
  #10ns start = 1'b1;
   string1   = {{102{5'b01101}},2'b0};//{128{4'b1001}};
   sequence1 = 4'b1101;
   #10ns;
// load 4-bit pattern into memory address 9, LSBs
  DUT.data_mem.core[9] = {4'b0,sequence1};  // load "Waldo"
// load string to be searched -- watch Endianness
  for(int i=0; i<64; i++)
    DUT.data_mem.core[95-i] = string1[7+8*i-:8];
// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.reg_file.core[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("string_instr.txt",DUT.instr_rom.core);
//  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  count_DUT = DUT.data_mem.core[10];
  #10ns  $display(count_beh,,,count_DUT);
  if(count_beh == count_DUT)	 // score another successful trial
    score++;
  #10ns;

// one more time!
   start = 1'b1;
   string1   = '1;//{{102{5'b01001}},2'b0};//{128{4'b1001}}; 		'h1 = (binary): 00000...1    '1	= binary 111111...111
   sequence1 = 4'b1111;
// load 4-bit pattern into memory address 9,
  #10ns DUT.data_mem.core[9] = {4'b0,sequence1};  // load "Waldo"
// load string to be searched -- watch Endianness
  for(int i=0; i<64; i++)
    DUT.data_mem.core[95-i] = string1[7+8*i-:8];
// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.reg_file.core[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("string_instr.txt",DUT.instr_rom.core);
//  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  count_DUT = DUT.data_mem.core[10];
  #10ns  $display(count_beh,,,count_DUT);
  if(count_beh == count_DUT)	 // score another successful trial
    score++;
  #10ns	  	 $stop;
end

always begin
  #5ns  clk = 1'b1;
  #5ns  clk = 1'b0;
end

endmodule
