; R4, R5 = mantissas of a, b, R6, R7 = exponents of a, b
				AREA text, CODE, READONLY
				EXPORT add_floats
				ENTRY
add_floats  	PUSH {r4, r5, r6, r7, r8, r9, r10}	; save registers that will be used 
				LDR r9, =0x007fffff  				; load mantissa mask
				MOV r6, r0, LSR #23					; shift exponent right
				AND r6, #0xFF						; extract exponent from R0 (a) 
				MOV r7, r1, LSR #23					; shift exponent right
				AND r7, #0xFF						; extract exponent from R1 (a)
				AND r4, r0, r9						; extract mantissa from R0 (a)
				AND r5, r1, r9						; extract mantissa from R1 (b)
				ORR r4, #0x800000					; insert implicit leading 1
				ORR r5, #0x800000					; insert implicit leading 1
				SUBS r2, r6, r7						; compare exponents
				LSRGT r5, r2						; right-shift b's mantissa
				SUBLT r2, r7, r6					; R8 = b's exponent – a's exponent
				LSRLT r4, r2						; right-shift a's mantissa
				ADD r8, r4, r5						; R4 = sum of mantissas
				AND r2, r8, #0x1000000				; extract overflow bit
				LSR r2, r2, #24						; shift overflow bit by 24
				LSR r8, r2							; right-shift mantissa by 1 bit if overflow bit = 1 
				ADDGE r2, r2, r6					; increment exponent if overflow bit = 1
				ADDLT r2, r2, r7					; increment exponent if overflow bit = 1
				LSL r2, r2, #23						; shift exponent into place
				AND r8, r8, r9						; mask fraction
				ORR r0, r2, r8						; combine mantissa and exponent 
				POP {r4, r5, r6, r7, r8, r9, r10}	; restore registers
				BX    lr							; return to caller
				END
