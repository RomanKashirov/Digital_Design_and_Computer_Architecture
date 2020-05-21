# Exercise 6.1
main:		addi $sp, $sp, -4 	# make room on stack
			sw   $ra, 0($sp)  	# store $ra
			
			addi $t0, $0, 5
			addi $t1, $0, 3
			
			add $t0, $t0, $t1
			sub $t1, $t0, $t1
			sub $t0, $t0, $t1
			
			lw   $ra, 0($sp)  	# restore $ra
			addi $sp, $sp, 4	# restore $sp
			jr $ra
