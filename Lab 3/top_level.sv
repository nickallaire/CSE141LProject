module top_level(
    input     start,
	input     CLK,
    output    haltProgram          // output to stop program
    );
	 
wire[15:0] newPC;
wire[15:0] PC;              // current program counter value

wire[ 8:0] Instruction;     // machine code instruction

wire[ 7:0] data_outA,       // reg file output addrA
           data_outB;       // reg file output addrB
           regWriteValue,   // reg file data_in
           memWriteValue,   // data mem write value
		   Mem_Out,         // output of data mem
		   //Target,          // target branch address
           memAddr,         // data mem addr
           accum,           // accumulator data
           aluOut;          // output of alu

wire[ 3:0] ci,              // carry in bits
    [ 3:0] co;              // carry out bits
			  
wire[ 2:0] aluOp,           // alu op signal
           accumReg,        // 3'b000
           write_addr;      // reg file write addr

wire[ 1:0] data;            // reg write data mux signal

wire       regDst,          // reg destination mux signal
           beq,             // beq signal
           blt,             // blt signal
           Branch,          // successfull branch
           mem,             // data mem branch mux signal
           rWrite,          // reg file write signal
           mWrite,          // data mem write signal
           mRead,           // data mem read signal 
           halt,            // halt signal from halt instruction
           zero,            // aluOut == 0
           equal,           // control signal specifying 2 registers are equal
           lessthan,        // control signal specifying reg1 < reg2
           clr;             // clr ov signal

logic      cycle_ct;        // how many instructions have been executed


    // Fetch = Program Counter + Instruction ROM
    // Program Counter
	pc PC1 (
	   .Branch		   	 ,
	   .Target  (newPC),
	   .Init      (start), 
	   .Halt       (halt), 
	   .CLK              , 
	   .PC               ,
       .haltProgram
	);
	
	
	// instruction ROM
	instr_ROM instr_ROM1(
	   .InstAddress            (PC), 
	   .InstrOut      (Instruction)
	);


    // generate control signals
    controll ctrl1(
        .opcode    (Instruction[8:6]),
        .func      (Instruction[5:3]),
        .aluOp                       ,
        .data                        ,
        .regDst                      ,
        .beq                         ,
        .blt                         ,
        .mem                         ,
        .rWrite                      ,
        .mWrite                      ,
        .mRead                       ,
        .halt                        ,
        .clr                          
    );


    // reg_addr_mux
    reg_dst_mux rdm1(
        .raddrA   (Instruction[5:3],
        .accumReg          (3'b000),
        .regDst                    ,
        .writeAddr (write_addr)
    );


    // reg file
	reg_file reg_file1 (
		.clk		               (CLK),
		.write_en               (rWrite),
		.raddrA       (Instruction[5:3]),
		.raddrB       (Instruction[2:0]), 
		.waddr		        (write_addr),
		.data_in	     (regWriteValue), 
		.data_outA                      , 
		.data_outB                      ,
		.accum
	);
	

    // alu
    alu alu1(
        .OP     (Instruction[8:6]),
        .FUNC   (Instruction[2:0]),
        .CI                   (ci),
        .INPUTA        (data_outA),
        .INPUTB        (data_outB),
        .OUT              (aluOut),
        .CO                   (co),
        .ZERO               (zero),
        .EQUAL             (equal),
        .LESSTHAN       (lessthan)
    );


    // carry in/out
    carry_bits cb1(
        .ci (ci)
    );


    // data branch mux
    data_branch_mux dbm1(
        .accum              ,
        //.const              ,
        .mem                ,
        .data_addr (memAddr)
    );

	// data mem
	data_mem data_mem1(
		.CLK,
		.DataAddress        (memAddr), // change later for LUT
		.ReadMem              (mRead), 
		.WriteMem            (mWrite), 
		.DataIn       (memWriteValue), 
		.DataOut            (Mem_Out)
	);


    // reg_write_mux
    reg_data_mux rdm1(
        .immed  (Instruction[5:0]),
        .mem             (Mem_out),
        .alu              (aluOut),
        .accum                    ,
        .data                     ,
        .writeData (regWriteValue)
    );


    // check branch values
    check_branch cb1(
        .pc              (PC),
        .dataOut    (Mem_out),
        .beq                 ,
        .blt                 ,
        .equal               ,
        .lessthan            ,
        .program_counter (newPC),
        .branch      (Branch)
    );


// count number of instructions executed
always@(posedge CLK)
  if (start == 1)
  	cycle_ct <= 0;
  else if(halt == 0)
  	cycle_ct <= cycle_ct+1;

endmodule
