module hazard(output logic StallF, StallD, 
				  input logic BranchD, JumpD, 
				  output logic ForwardAD, ForwardBD, 
				  input logic [4:0] RsD, RtD, 
				  output logic FlushE, 
				  input logic [4:0] RsE, RtE, 
				  output logic [1:0] ForwardAE, ForwardBE, 
				  input logic [4:0] WriteRegE, 
				  input logic MemtoRegE, RegWriteE, 
				  input logic [4:0] WriteRegM,
				  input logic RegWriteM, 
				  input logic [4:0] WriteRegW, 
				  input logic RegWriteW,
				  input logic MemtoRegM);
	
	logic lwstall, branchstall;
	// page 213 of solutions				
	assign FlushE = lwstall | branchstall | JumpD;
	// page 489
	assign ForwardAE = ((RsE != 0) & (RsE == WriteRegM) & RegWriteM) ? 2'b10 : 
			 (((RsE != 0) & (RsE == WriteRegW) & RegWriteW) ? 2'b01 : 2'b00);
			 
	assign ForwardBE = ((RtE != 0) & (RtE == WriteRegM) & RegWriteM) ? 2'b10 : 
			 (((RtE != 0) & (RtE == WriteRegW) & RegWriteW) ? 2'b01 : 2'b00);
  
   assign lwstall = ((RsD == RtE) | (RtD == RtE)) & MemtoRegE;
   assign StallF = lwstall | branchstall;
	assign StallD = lwstall | branchstall;
	
	assign ForwardAD = (RsD != 0) & (RsD == WriteRegM) & RegWriteM;
   assign ForwardBD = (RtD != 0) & (RtD == WriteRegM) & RegWriteM;
   
	assign branchstall =  BranchD & RegWriteE & (WriteRegE == RsD | WriteRegE == RtD)|
			 BranchD & MemtoRegM & (WriteRegM == RsD | WriteRegM == RtD);
  
endmodule



