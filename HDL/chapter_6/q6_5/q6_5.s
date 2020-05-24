# Question 6.5
# $t0 - i, $v0 - result $t5 = 31
main:			addi $sp, $sp, -4 	# make room on stack
				sw   $ra, 0($sp)  	# store $ra
				lui $t3, 0xF00       # 
				ori $t3, $t3, 0x0000  #
				add $a0, $0, $t3
				jal reverse_bits
				add $t3, $0, $v0
				lw   $ra, 0($sp)  	# restore $ra
				addi $sp, $sp, 4	# restore $sp
				jr $ra
reverse_bits:	add $t0, $0, $0
				add $v0, $0, $0
				addi $t5, $0, 31
rev_while:		slti $t2, $t0, 16
				beq $t2, $0, rev_done
				sllv $t2, $t2, $t0		# $t2 = (1 << i)
				and $t2, $t2, $a0		# $t2 = (1 << i)&number)
				sll $t3, $t0, 1			# $t3 = (i << 1)
				sub $t3, $t5, $t3		# $t3 = (31-(i << 1))
				sllv $t2, $t2, $t3		# $t2 = (((1 << i)&number)<<(31-(i << 1)))
				or $v0, $v0, $t2		# result = result | (((1 << i)&number)<<(31-(i << 1)))
				addi $t2, $0, 1
				sub $t4, $t5, $t0		# $t4 = (31-i)
				sllv $t2, $t2, $t4		# $t2 = (1 << (31-i))
				and $t2, $t2, $a0		# $t2 = ((1 << (31-i))&number)
				srlv $t2, $t2, $t3		# $t2 = (((1 << (31-i))&number)>>(31-(i << 1)))
				or $v0, $v0, $t2		# result = result | (((1 << i)&number)<<(31-(i << 1)))
				addi $t0, $t0, 1		# i++
				j rev_while
rev_done:		jr $ra
