# Exercise 6.28
main:		addi $sp, $sp, -4 	# make room on stack
			sw   $ra, 0($sp)  	# store $ra
			addi $a0, $0, 2	# n = 2
			addi $a1, $0, 4		# k = 4
			jal func
			lw   $ra, 0($sp)  	# restore $ra
			addi $sp, $sp, 4	# restore $sp
			jr $ra
func:	addi $sp, $sp, -12 	# make room on stack
			sw   $ra, 8($sp)    # save return address
            sw   $s0, 4($sp)    # save $s0
			addi $s0, $a1, 2 	# int b = k + 2;
			beq $a0, $0, n_eq_z	# if (n == 0) b = 10;
			
			
n_eq_z:		addi $s0, $0, 10	# b = 10
done:		mul $v0, $s0, $a1	# return b * k
			lw   $s0, 4($sp)    # restore $s0
            lw   $ra, 8($sp)    # restore return address
            addi $sp, $sp, 12   # restore stack pointer
			jr $ra 				# return







