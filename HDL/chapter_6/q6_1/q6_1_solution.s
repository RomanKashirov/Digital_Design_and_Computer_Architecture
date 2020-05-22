# Question 6.1 solution

main:		addi $sp, $sp, -4 	# make room on stack
			sw   $ra, 0($sp)  	# store $ra
			
			addi $t0, $0, 5
			addi $t1, $0, 3
			
			xor $t0, $t0, $t1  # $t0 = $t0 XOR $t1
			xor $t1, $t0, $t1  # $t1 = original value of $t0
			xor $t0, $t0, $t1  # $t0 = original value of $t1

			
			lw   $ra, 0($sp)  	# restore $ra
			addi $sp, $sp, 4	# restore $sp
			jr $ra
