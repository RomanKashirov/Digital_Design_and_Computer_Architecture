# Exercise 6.35
main:		addi $sp, $sp, -4 	# make room on stack
			sw   $ra, 0($sp)  	# store $ra
			lui  $a0, 0x451D       # $a0 = 0x451D0000
			ori  $a0, $a0, 0x1B68  # $a0 = 0x451D1B68 = 2513.713
			lui  $a1, 0x4049       # $a1 = 0x40490000
			ori  $a1, $a0, 0x0E56  # $a1 = 40490E56 = 3.1415
			jal add_floats 
			lw   $ra, 0($sp)  	# restore $ra
			addi $sp, $sp, 4	# restore $sp
			jr $ra
add_floats:	addi $sp, $sp, -8 	# make room on stack
			sw   $s0, 4($sp)  	# store $s0
			sw   $s1, 0($sp)  	# store $s1
			
			
			lw   $s1, 0($sp)  	# restore $s1
			lw   $s0, 4($sp)  	# restore $s0
			addi $sp, $sp, 8	# restore $sp
			jr $ra
