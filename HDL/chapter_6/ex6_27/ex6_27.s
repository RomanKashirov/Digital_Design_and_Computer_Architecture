# Exercise 6.27
main:		addi $sp, $sp, -4 	# make room on stack
			sw   $ra, 0($sp)  	# store $ra
			addi $a0, $0, 3
			jal setArray
			lw   $ra, 0($sp)  	# restore $ra
			addi $sp, $sp, 4	# restore $sp
			jr $ra
setArray:	addi $sp, $sp, -48 	# make room on stack
			sw   $ra,48($sp)   # save return address
            sw   $s0,44($sp)   # save $s0
            add $t0, $0, $sp
			add $s0, $0, $0		# i = 0
	loop:	addi $t3, $0, 10
			slt $t3, $s0, $t3
			beq $t3, $0, done
			add $a1, $0, $s0
			jal compare
			sw $v0, 0($t0) 		# array[i] = $v0
			addi $t0, $t0, 4
			addi $s0, $s0, 1
			j loop
done:		lw   $s0,44($sp)   # restore $s0
            lw   $ra,48($sp)   # restore return address
            addi $sp,$sp,-48    # restore stack pointer
			jr $ra 				# return
compare:	addi $sp, $sp, -4 	# make room on stack
			sw $ra, 0($sp) 		# store $ra
			jal subtract
			slt  $v0,$v0,$0     # $v0=1 if sub(a,b) < 0 (return 0)
			slti $v0,$v0,1      # $v0=1 if sub(a,b)>=0, else $v0 = 0
			lw $ra, 0($sp) 	    # restore $ra
			addi $sp, $sp, 4    # restore $sp
			jr $ra 				# return
subtract:	sub $v0, $a0, $a1
			jr $ra 				# return







