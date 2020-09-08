// Hazard Unit

module hazard(	input logic Match_1E_M, Match_1E_W, Match_2E_M, Match_2E_W, Match_12D_E,
					input logic RegWriteM, RegWriteW, MemtoRegE, PCWrPendingF,
					input logic PCSrcW, BranchTakenE,
					output logic StallF, StallD, FlushD, FlushE,
					output logic [1:0]ForwardAE, ForwardBE);
				
	//  forwarding (bypassing) logic

	assign ForwardAE = (Match_1E_M & RegWriteM) ? 2'b10 : // SrcAE = ALUOutM
			 (Match_1E_W & RegWriteW) ? 2'b01 :					// SrcAE = ResultW
			 2'b00);														// SrcAE from regfile
		
	assign ForwardBE = (Match_2E_M & RegWriteM) ? 2'b10 : // SrcBE = ALUOutM
			 (Match_2E_W & RegWriteW) ? 2'b01 :					// SrcBE = ResultW
			 2'b00);														// SrcBE from regfile
			 
	// Solving Data Hazards with Stalls & Solving Control Hazards
	
	logic LDRstall;
	assign LDRstall = Match_12D_E & MemtoRegE;
	assign StallF = LDRstall | PCWrPendingF;
	assign StallD = LDRstall;
	assign FlushE = LDRstall | BranchTakenE;
	assign FlushD = PCWrPendingF | PCSrcW | BranchTakenE;
			 
endmodule
