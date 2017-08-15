//This file defines the parameters used in the alu
package definitions;
    
// Instruction map
	const logic [2:0] kCOMP = 'b000;
	const logic [2:0] kADD  = 'b001;
  const logic [2:0] kSL   = 'b010;
	const logic [2:0] kSR   = 'b011;
  const logic [2:0] kSRO  = 'b100;
    
   typedef enum logic[1:0] {
        ADDU    = 2'h0, 
        SUBU    = 2'h1, 
        AND     = 2'h2,
        XOR     = 2'h3
    } op_mne;
    
endpackage // defintions
