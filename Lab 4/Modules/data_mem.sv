// Create Date:    2017.01.25
// Design Name:
// Module Name:    DataRAM
//
module data_mem(
  input              CLK,
  input [7:0]        DataAddress,
  input              ReadMem,
  input              WriteMem,
  input [7:0]        DataIn,
  output logic[7:0]  DataOut);

  logic [7:0] core [256];

//  initial 
//    $readmemh("dataram_init.list", core);
  always_comb
    if(ReadMem) begin
      DataOut = core[DataAddress];
	  //$display("Memory read M[%d] = %d",DataAddress,DataOut);
    end else 
      DataOut = 8'bz;



  always_ff @ (posedge CLK)
    if(WriteMem) begin
      core[DataAddress] = DataIn;
    //$display("Mem 0: %d", core[126]);
    //$display("Mem 1: %d", core[127]);
    end

endmodule
