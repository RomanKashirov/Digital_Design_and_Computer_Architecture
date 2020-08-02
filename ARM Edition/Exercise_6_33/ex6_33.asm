;Exercise_6_33
; R4 = i

SET_ARRAY
	PUSH {R4, R5, LR} 			; save preserved registers used by SET_ARRAY
	SUB SP, SP, #40 			; make space on stack for  array
	MOV R4, #0 					; i = 0
	MOV  R5, R0      			; R5 = num
FOR
	MOV R1, R4					; set up input arguments
	BL COMPARE					; call compare function
	STR R0, [SP, R4,  LSL #2]	; array[i] = return value
	ADD R4, R4, #1				; increment i
	MOV  R0, R5      			; set up input arguments
	CMP R4, 10
	BLT FOR
	ADD SP, SP, #40 			; deallocate stack space
	POP {R4, R5, LR} 			; restore preserved registers
	MOV PC, LR 					; return from SET_ARRAY

COMPARE
	PUSH {LR} 					; save LR
	BL SUBTRACTION				; call SUBTRACTION function
	CMP R0, #0					
	MOVGE R0, #1     			; if yes, R0 = 1 
	MOVLT R0, #0     			; if no, R0 = 0 
	POP {LR} 					; restore LR
	MOV PC, LR 					; return from COMPARE
	
SUBTRACTION
	SUB R0, R0, R1				; return a-b
	MOV PC, LR 					; return from SUBTRACTION
	
	
	
	
	