;Exercise_6_33
; R4 = i

SET_ARRAY
	PUSH {R4, LR} ; save preserved registers used by SET_ARRAY
	SUB SP, SP, #40 ; make space on stack for  array
	
	
	
	
	ADD SP, SP, #40 ; deallocate stack space
	POP {R4, LR} ; restore preserved registers
	MOV PC, LR ; return from SET_ARRAY

