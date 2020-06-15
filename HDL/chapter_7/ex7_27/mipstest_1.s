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
		  j loop				#20			08000002
shit:  	 sw    $3, 80($0)      	#24 		ac030050
          lw    $2, 80($0)      #28 		8c020050
          j     end             #32 		0800000A
          addi  $2, $0, 1       #36 		20020001
end:      sw    $2, 84($0)      #40 		ac020054