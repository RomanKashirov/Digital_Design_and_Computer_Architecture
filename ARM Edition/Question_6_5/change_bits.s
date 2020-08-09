
				AREA text, CODE, READONLY
				EXPORT change_bits
				ENTRY
				
change_bits  	LDR R1, =0x0000ffff
				AND R2, R0, R1
				LSL R2, R2, #16
				LSR R3, R0, #16
				AND R3, R3, R1
				ORR R0, R2, R3
				LDR R1, =0x00ff00ff
				AND R2, R0, R1
				LSL R2, R2, #8
				LSR R3, R0, #8
				AND R3, R3, R1
				ORR R0, R2, R3
				LDR R1, =0x0f0f0f0f
				AND R2, R0, R1
				LSL R2, R2, #4
				LSR R3, R0, #4
				AND R3, R3, R1
				ORR R0, R2, R3
				LDR R1, =0x33333333
				AND R2, R0, R1
				LSL R2, R2, #2
				LSR R3, R0, #2
				AND R3, R3, R1
				ORR R0, R2, R3
				LDR R1, =0x55555555
				AND R2, R0, R1
				LSL R2, R2, #1
				LSR R3, R0, #1
				AND R3, R3, R1
				ORR R0, R2, R3
				BX    lr							; return to caller
				END

