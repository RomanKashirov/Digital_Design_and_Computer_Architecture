# Exercise 6.33
main:		addi $sp, $sp, -44 	# make room on stack
			sw   $ra, 40($sp)  	# store $ra
			add $t0, $0, $sp
			addi $t1, $0, 0
			addi $t2, $0, 10
			addi $t3, $0, 0x1234			
fill_array:	sw $t3, 0($t0)
			addi $t0, $t0, 4
			addi $t1, $t1, 1
			addi $t3, 0x7999
			bne $t1, $t2, fill_array
			add $a0, $0, $sp
			jal little2big
			lw   $ra, 40($sp)  	# restore $ra
			addi $sp, $sp, 44	# restore $sp
			jr $ra
little2big:	addi $t0, $a0, 0
			addi $t1, $0, 0
			addi $t2, $0, 10
loop:		lw $t3, 0($t0)
			andi $t4, $t3, 0xFF
			sll $t4, $t4, 24
			andi $t5, $t3, 0xFF00
			sll $t5, $t5, 8
			srl $t6, $t3, 8
			andi $t6, $t6, 0xFF00
			srl $t7, $t3, 24
			andi $t7, $t7, 0xFF
			or $t3, $t4, $t5
			or $t3, $t3, $t6
			or $t3, $t3, $t7
			sw $t3, 0($t0)
			addi $t0, $t0, 4
			addi $t1, $t1, 1
			bne $t1, $t2, loop
			jr $ra
