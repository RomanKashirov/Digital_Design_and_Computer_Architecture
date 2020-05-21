# Exercise 6.35
main:		addi $sp, $sp, -4 	# make room on stack
			sw   $ra, 0($sp)  	# store $ra
			lui  $a1, 0x4700       # $a1 = 0x47000000
			ori  $a1, $a1, 0x0000  # $a1 = 0x47000000 = 32768
			lui  $a0, 0x4049       # $a0 = 0x40490000
			ori  $a0, $a0, 0x0E56  # $a0 = 0х40490E56 = 3.1415
			jal add_floats 
			lw   $ra, 0($sp)  	# restore $ra
			addi $sp, $sp, 4	# restore $sp
			jr $ra
add_floats:	addi $sp, $sp, -8 	# make room on stack
			sw   $s0, 4($sp)  	# store $s0
			sw   $s1, 0($sp)  	# store $s1
			add $s0, $0, $a0
			add $s1, $0, $a1
			
			#  Extract exponent and fraction bits
			srl $t0, $s0, 23	# 1 Exponent
			srl $t1, $s1, 23	# 2 Exponent
			
			sll $t2, $s0, 9
			srl $t2, $t2, 9		# 1 Fraction
			
			sll $t3, $s1, 9
			srl $t3, $t3, 9		# 2 Fraction
			
			# Prepend leading 1 to form the mantissa
			addi $t4, $0, 1
			sll $t4, $t4, 23	# $t4 = 0x800000 
			add $t2, $t2, $t4	# 1 Mantissa
			add $t3, $t3, $t4 	# 2 Mantissa
			
			# Compare exponents, Shift smaller mantissa if necessary
			sub $t5, $t0, $t1
			bltz $t5, t1_more
			srlv $t3, $t3, $t5
			j done_comp
t1_more:	sub $t5, $t1, $t0
			srlv $t2, $t2, $t5
			add $t0, $0, $t1	# New exponent
done_comp:	
			# Add mantissas, Normalize mantissa and adjust exponent if necessary
			add $t2, $t2, $t3
			srl $t5, $t2, 24
			srlv $t2, $t2, $t5
			sll $t2, $t2, 9
			srl $t2, $t2, 9		# Fraction 
			add $t0, $t0, $t5	# Adjusted exponent
						
			# Assemble exponent and fraction back into floating-point number
			sll $t0, $t0, 23	
			add $v0, $t0, $t2
			
			lw   $s1, 0($sp)  	# restore $s1
			lw   $s0, 4($sp)  	# restore $s0
			addi $sp, $sp, 8	# restore $sp
			jr $ra
