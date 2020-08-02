; Exercise_6_33
; R0 - address of array
; R12 - i

LITTLE_TO_BIG
	MOV R12, #0
LOOP
	LDR R2, [R0, R12,  LSL #2]	; array[i]
	LSL R3, R2, #24
	AND R1, R2, #0xFF00
	ORR R3, R3, R1, LSL #8
	AND R1, R2, 0xFF0000
	ORR R3, R3, R1, LSR #8
	ORR R3, R3, R2, LSR #24
	STR R3, [R0, R12,  LSL #2]	; array[i]
	ADD R12, R12, #1
	CMP R12, 10
	BLT LOOP
	MOV PC, LR 					; return from LITTLE_TO_BIG