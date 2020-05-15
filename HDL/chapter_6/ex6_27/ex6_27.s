# Exercise 6.27


main:
	addi $sp, $sp, -4 	 # make room on stack
	sw   $ra, 0($sp)  	 # store $ra
	addi $a0, $0, 2
	
	jal setArray
	lw   $ra, 0($sp)  	 # restore $ra
	addi $sp, $sp, 4	# restore $sp
	jr $ra

setArray: 
	addi $sp, $sp, -8 	# make room on stack
	sw $s0, 4($sp) 		# store $s0
	sw $ra, 0($sp) 		# store $ra
	# $t0 = base address of array
	lui $t0, 0x1000 		# $t0 = 0x10000000
	ori $t0, $t0, 0x7000 	# $t0 = 0x10007000
	add $s0, $0, $0			# i = 0
loop:
	addi $t3, $0, 10
	slt $t3, $s0, $t3
	beq $t3, $0, done
	add $a1, $0, $s0
	jal compare
	sw $v0, 0($t0) # array[i] = $v0
	addi $t0, $t0, 4
	addi $s0, $s0, 1
	j loop
done:
	lw $ra, 0($sp) # restore $ra
	lw $s0, 4($sp) # restore $s0
	addi $sp, $sp, 8 # restore $sp
	jr $ra # return
	

compare: 
	addi $sp, $sp, -12 	# make room on stack
	sw $a1, 8($sp)		#store $a1
	sw $a0, 4($sp) 		# store $a0
	sw $ra, 0($sp) 		# store $ra
	jal sub_
	bgtz $v0, gr
	beq $v0, $0,gr
	add $v0, $0, $0
	j compare_done
gr:
	addi $v0, $0, 1
compare_done:
	lw $ra, 0($sp) # restore $ra
	lw $a0, 4($sp) # restore $a0
	lw $a1, 8($sp) # restore $a1
	addi $sp, $sp, 12 # restore $sp
	jr $ra # return	
	
sub_:
	sub $v0, $a0, $a1
	jr $ra # return







