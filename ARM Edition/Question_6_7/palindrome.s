
				AREA text, CODE, READONLY
				EXPORT palindrome
				ENTRY
				
palindrome  	PUSH {R4}
				MOV R1, #0							; i = 0
				MOV R3, #0							; j = 0
seek_symb		LDRB R2, [R0, R1]					; R2 = str[i]
				CMP R2, #0							; str[i] = '\0'?
				BEQ compare
				ADD R1, R1, #1						; i++
				B seek_symb
compare			SUB R1, R1, #1						; return i - 1
				CMP R1, R3
				BLE pal
				LDRB R2, [R0, R1]					; R2 = str[i]
				LDRB R4, [R0, R3]					; R2 = str[i]
				CMP R2, R4
				BNE not_pal
				ADD R3, #1
				B compare
pal				MOV R0, #1
				B done
not_pal			MOV R0, #0
done			POP {R4}
				BX    lr							; return to caller
				END

