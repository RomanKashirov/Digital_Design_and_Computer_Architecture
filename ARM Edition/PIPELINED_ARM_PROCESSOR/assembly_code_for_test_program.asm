;		PROGRAM 				ADDR	COMMENTS 							BINARY MACHINE CODE                     HEX CODE
MAIN 	SUB R0, R15, R15	;	00  	R0 = 0 			 			1110 000 0010 0 1111 0000 0000 0000 1111  		E04F000F
		ADD R2, R0, #5    	; 	04 		R2 = 5      	 			1110 001 0100 0 0000 0010 0000 0000 0101  		E2802005
		ADD R3, R0, #12    	; 	08 		R3 = 12          			1110 001 0100 0 0000 0011 0000 0000 1100  		E280300C
		SUB R7, R3, #9     	; 	0C 		R7 = 3           			1110 001 0010 0 0011 0111 0000 0000 1001  		E2437009
		ORR R4, R7, R2    	; 	10 		R4 = 3 OR 5 = 7  			1110 000 1100 0 0111 0100 0000 0000 0010  		E1874002
		AND R5, R3, R4    	; 	14 		R5 = 12 AND 7 = 4   		1110 000 0000 0 0011 0101 0000 0000 0100  		E0035004
		ADD R5, R5, R4     	; 	18 		R5 = 4 + 7 = 11     		1110 000 0100 0 0101 0101 0000 0000 0100  		E0855004
		SUBS R8, R5, R7    	; 	1C 		R8 = 11 - 3 = 8, set Flags  1110 000 0010 1 0101 1000 0000 0000 0111  		E0558007
		BEQ END 			; 	20 		shouldn't be taken          0000 1010 0000  0000 0000 0000 0000 1100 		0A00000C
		SUBS R8, R3, R4     ; 	24 		R8 = 12 - 7  = 5            1110 000 0010 1 0011 1000 0000 0000 0100  		E0538004
		BGE AROUND 			; 	28 		should be taken             1010 1010 0000  0000 0000 0000 0000 0000  		AA000000
		ADD R5, R0, #0      ;   2C		should be ski pped          1110 001 0100 0 0000 0101 0000 0000 0000  		E2805000
AROUND  SUBS R8, R7, R2 	;   30 		R8 = 3 - 5 = -2, set Flags  1110 000 0010 1 0111 1000 0000 0000 0010  		E0578002
        ADDLT R7, R5, #1    ;   34		R7 = 11 + 1 = 12 			1011 001 0100 0 0101 0111 0000 0000 0001 		B2857001
		SUB R7, R7, R2      ;   38 		R7 = 12 - 5 = 7 			1110 000 0010 0 0111 0111 0000 0000 0010  		E0477002
		STR R7, [R3, #84]   ;   3C 		mem[12+84] = 7 				1110 010 1100 0 0011 0111 0000 0101 0100  		E5837054
		LDR R2, [R0, #96]   ; 	40  	R2 = mem[96] = 7 			1110 010 1100 1 0000 0010 0000 0110 0000  		E5902060
		ADD R15, R15, R0 	; 	44 		PC = PC+8 (skips next)      1110 000 0100 0 1111 1111 0000 0000 0000 		E08FF000
		ADD R2, R0, #14     ;   48      shouldn't happen            1110 001 0100 0 0000 0010 0000 0000 0001  		E280200E
		B END 				; 	4C 		always taken 				1110 1010 0000  0000 0000 0000 0000 0001 		EA000001
		ADD R2, R0, #13     ; 	50 		shouldn't happen 			1110 001 0100 0 0000 0010 0000 0000 0001  		E280200D
		ADD R2, R0, #10     ; 	54 		shouldn't happen 			1110 001 0100 0 0000 0010 0000 0000 0001  		E280200A
		ROR R2, R2, #31		;																						E1A02FE2
END 	STR R2,[R0,#100]  		; 110		mem[100] = 14															E5802064 



		
		


