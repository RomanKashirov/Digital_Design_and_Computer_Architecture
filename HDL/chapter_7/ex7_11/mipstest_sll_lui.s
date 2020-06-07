# mipstest_1.asm

# Тест процессора MIPS для отбитых.
# add, sub, and, or, slt, addi, lw, sw, beq, j
# Если успешно, по адресу 84 запишется 666
#         Assembly              Address   Machine
main:     addi  $2, $0, 6       #0 			20020006
          addi  $3, $0, 0       #4 			20030000
loop:     beq   $2, $0, shit	#8 			10400003 
          addi   $3, $3, 111    #12 		2063006f
		  addi  $2, $2, -1		#16 		2042ffff
		  j loop				#20			08100002
shit:  	 sw    $3, 80($0)      	#24 		ac030050
          lw    $2, 80($0)      #28 		8c020050
		  sll $2, $2, 3			#32			000210c0
		  j     end             #36 		0810000B
          addi  $2, $0, 1       #40 		20020001
end:      lui $3, 1				#44
		add $2, $2, $3			#48
		sw    $2, 84($0)      #52 			ac020054