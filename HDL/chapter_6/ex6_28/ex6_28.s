# Exercise 6.28
main:		addi $sp, $sp, -4 	# make room on stack
			sw   $ra, 0($sp)  	# store $ra
			addi $a0, $0, 2		# n = 2
			addi $a1, $0, 4		# k = 4
			jal func
			lw   $ra, 0($sp)  	# restore $ra
			addi $sp, $sp, 4	# restore $sp
			jr $ra
func:		addi $sp, $sp, -8 	# make room on stack
			sw   $ra, 4($sp)    # save return address
            sw   $s0, 0($sp)    # save $s0
			addi $s0, $a1, 2 	# int b = k + 2;
			beq $a0, $0, n_eq_z	# if (n == 0) b = 10;
			addi $sp, $sp, -8
			sw   $a0, 4($sp)    # save $a0
            sw   $a1, 0($sp)    # save $a1
			addi $a0, $a0, -1
			addi $a1, $a1, 1
			jal func
			lw   $a1, 0($sp)    # restore $a1
            lw   $a0, 4($sp)    # restore $a0
			addi $sp, $sp, 8
			mul $t0, $a0, $a0
			add $t0, $t0, $v0
			add $s0, $s0, $t0
			j done
n_eq_z:		addi $s0, $0, 10	# b = 10
done:		mul $v0, $s0, $a1	# return b * k
			lw   $s0, 0($sp)    # restore $s0
            lw   $ra, 4($sp)    # restore return address
            addi $sp, $sp, 8   # restore stack pointer
			jr $ra 				# return







