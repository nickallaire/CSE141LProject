//This file defines the parameters used in the alu
package definitions;
    
// Instruction map
	const logic [2:0] kAorC = 'b000;
  const logic [2:0] kSL   = 'b011;
	const logic [2:0] kSR   = 'b100;
  const logic [2:0] kSRO  = 'b101;
    
   typedef enum logic[1:0] {
        ADDU    = 2'h0, 
        SUBU    = 2'h1, 
        AND     = 2'h2,
        XOR     = 2'h3
    } op_mne;
    
endpackage // defintions
