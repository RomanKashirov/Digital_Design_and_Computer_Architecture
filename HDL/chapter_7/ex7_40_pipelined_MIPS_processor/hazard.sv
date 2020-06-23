module hazard(output logic StallF, StallD, 
				  input logic BranchD, JumpD, 
				  output logic ForwardAD, ForwardBD, 
				  input logic [4:0] RsD, RtD, 
				  output logic FlushE, 
				  input logic [4:0] RsE, RtE, 
				  output logic [1:0] ForwardAE, ForwardBE, 
				  input logic [4:0] WriteRegE, 
				  input logic MemtoregE, RegWriteE, 
				  input logic [4:0] WriteRegM,
				  input logic RegWriteM, 
				  input logic [4:0] WriteRegW, 
				  input logic RegWriteW);
	
	logic lwstall, branchstall;
	// page 213 of solutions				
	assign FlushE = lwstall | branchstall | JumpD
	// page 489
	assign ForwardAE = ((RsE != 0) & (RsE == WriteRegM) & RegWriteM) ? 2'b10 : (((RsE != 0) & (RsE == WriteRegW) & RegWriteW) ? 2'b01 : 2'b00);
  
  
  
  
endmodule



