
				AREA text, CODE, READONLY
				EXPORT change_words
				EXPORT seek_symb 
				EXPORT change_chars
				ENTRY
				; R4 - char *str, R5 - eofstr\str[eofw+1], R6 - sofw, R7 - eofw, R8 - eofw+1
change_words	PUSH {LR, R4, R5, R6, R7, R8}
				MOV R4, R0
				MOV R1, #0
				MOV R2, #0
				BL seek_symb
				MOV R5, R0							; eofstr = seek_symb(str, '\0', 0)
				MOV R0, R4
				MOV R1, #0
				MOV R2, R5
				BL change_chars						; change_chars(str, 0, eofstr)
				MOV R6, #0							; sofw = 0
				MOV R7, #0							; eofw = 0
FUNC_LOOP		ADD R8, R7, #1
				LDRB R5, [R4, R8]					; str[eofw+1]			
				CMP R5, #0							; str[eofw+1]!= '\0'
				BEQ END_FUNC
				MOV R0, R4
				MOV R1, #32
				MOV R2, R6
				BL seek_symb
				MOV R7, R0
				MOV R0, R4
				MOV R1, R6
				MOV R2, R7
				BL change_chars
				ADD R6, R7, #2
				B FUNC_LOOP
END_FUNC		POP {LR, R4, R5, R6, R7, R8}
				BX    lr							; return to caller
				; R0 - char *str, R1 - char symb, R2 - int start, R3 - str[i]
seek_symb		LDRB R3, [R0, R2]					; R3 = str[i]
				CMP R3, R1							; str[i] = symb?
				BEQ SEEK_DONE
				CMP R3, #0							; str[i] = '\0'?
				BEQ SEEK_DONE
				ADD R2, R2, #1						; i++
				B seek_symb
SEEK_DONE		SUB R0, R2, #1						; return i - 1
				BX    lr							; return to caller

				; R0 - char *str, R1 - i, R2 - j, R3 - str[i], R4 - str[j]
change_chars	PUSH {R4}
CHANGE_LOOP		CMP R2, R1
				BLE CHANGE_END						; j > i
				LDRB R3, [R0, R1]					
				LDRB R4, [R0, R2]					
				STRB R3, [R0, R2]
				STRB R4, [R0, R1]
				ADD R1, R1, #1						; i++
				SUB R2, R2, #1						; j--
				B CHANGE_LOOP
CHANGE_END		POP {R4}
				BX    lr
				END

