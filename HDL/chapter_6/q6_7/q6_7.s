# Question 6.7 
# racecar
# 114 97 99 101 99 97 114
# 0x72 0x61 0x63 0x65 0x63 0x61 0x72 0x00
  
main:			addi $sp, $sp, -12 	# make room on stack
				sw   $ra, 8($sp)  	# store $ra
				
				lui $s0, 0x6563       # 
				ori $s0, $s0, 0x6172  # 
				sw   $s0, 0($sp)  	# store race
				
				lui $s0, 0x0072       # 
				ori $s0, $s0, 0x6163  # 
				sw   $s0, 4($sp)  	# store car
								
				add $a0, $0, $sp
				jal palindrome
				
				lw   $ra, 8($sp)  	# restore $ra
				addi $sp, $sp, 12	# restore $sp
				jr $ra

palindrome:	
				add $t0, $0, $0		# int eofstr = 0;
				add $t1, $0, $0		# int sofstr = 0;
				
eofstr:			add $t2, $t0, $a0 			
				lb $t3, 0($t2) 
				beq $t3, $0, eofstr__done
				addi $t0, $t0, 1
				j eofstr
eofstr__done:	addi $t0, $t0, -1
				slt $t4, $t1, $t0
				beq $t4, $0, yes
				add $t2, $t0, $a0 			
				lb $t3, 0($t2)		# string[eofstr]
				add $t2, $t1, $a0 			
				lb $t4, 0($t2)		# string[sofstr]
				bne $t3, $t4, no
				add $t1, $t1, 1
				j eofstr__done

yes:			addi $v0, $0, 1
				jr $ra
				
no:				add $v0, $0, $0
				jr $ra






