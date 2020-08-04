; R4, R5 = mantissas of a, b, R6, R7 = exponents of a, b
				AREA text, CODE, READONLY
				EXPORT add_floats
				ENTRY
add_floats  	MOV r6, r0, LSR #23
				MOV r7, r1, LSR #23
				MOV r4, r0, LSL #9
				LSR r4, r4, #9
				MOV r5, r1, LSL #9
				LSR r5, r5, #9
				ORR r4, #0x800000
				ORR r5, #0x800000
				SUBS r2, r6, r7
				LSRGE r5, r2
				SUBLT r2, r7, r6
				LSRLT r4, r2
				ADD r8, r4, r5
				AND r2, r8, #0x1000000
				ADDGE r2, r2, r6
				ADDLT r2, r2, r7
				LSL r2, r2, #23
				MOV r8, r8, LSL #9
				LSR r8, r8, #9
				ORR r0, r2, r8
				BX    lr
				END
