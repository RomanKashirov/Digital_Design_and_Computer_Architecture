# Question 6.4
 
main:			addi $sp, $sp, -4 	# make room on stack
				sw   $ra, 0($sp)  	# store $ra
				lui $a0, 0x6C6C       # 
				ori $a0, $a0, 0x6548  #
				jal seek_one
				lw   $ra, 0($sp)  	# restore $ra
				addi $sp, $sp, 4	# restore $sp
				jr $ra
seek_one:		add $t0, $0, $0		# i = 0
				add $t1, $0, $0		# result = 0
loop:			sltiu $t3, $t0, 32
				beq $t3, $0, seek_done
				sllv $t3, $t3, $t0
				and $t3, $t3, $a0
				addi $t0, $t0, 1
				beq $t3, $0, loop
				addi $t1, $t1, 1
				j loop
seek_done:		add $v0, $0, $t1
				jr  $ra
