# Question 6.3 
# Hello world
# 0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x20, 0x77, 0x6F, 0x72 , 0x6C, 0x64, 0x00
 
main:			addi $sp, $sp, -16 	# make room on stack
				sw   $ra, 12($sp)  	# store $ra
				
				lui $s0, 0x6C6C       # 
				ori $s0, $s0, 0x6548  # 
				sw   $s0, 0($sp)  	# store Hell
				
				lui $s0, 0x6F77       # 
				ori $s0, $s0, 0x206F  # 
				sw   $s0, 4($sp)  	# store o wo
				
				lui $s0, 0x0064       # 
				ori $s0, $s0, 0x6C72  # 
				sw   $s0, 8($sp)  	# store rld
				add $a0, $0, $sp
				jal shitty_func
				
				lw   $ra, 12($sp)  	# restore $ra
				addi $sp, $sp, 16	# restore $sp
				jr $ra

shitty_func:	addi $sp, $sp, -16 	# make room on stack
				sw   $ra, 0($sp)  	# store $ra
				sw   $s0, 4($sp)  	# store $ra
				sw   $s1, 8($sp)  	# store $ra
				sw   $s2, 12($sp)  	# store $ra
				add $s0, $0, $0		# int eofstr = 0;
				add $s1, $0, $0		# int eofword = 0;
				add $s2, $0, $0		# int sofword = 0;
eofstr:			add $t3, $s0, $a0 			
				lb $t4, 0($t3) 
				beq $t4, $0, eofstr__done
				addi $s0, $s0, 1
				j eofstr
eofstr__done:	add $a1, $0, $0
				addi $a2, $s0, -1
				jal reverse
eofstr1:		add $t3, $s1, $a0 			
				lb $t4, 0($t3) 
				beq $t4, $0, done1
eofword:		add $t3, $s1, $a0 			
				lb $t4, 0($t3) 
				beq $t4, $0, eofword_done
				addi $t4, $t4, -32 
				beq $t4, $0, eofword_done
				addi $s1, $s1, 1
				j eofword
eofword_done:	add $a1, $0, $s2
				addi $a2, $s1, -1
				jal reverse
				addi $s1, $s1, 1	#eofword++
				add $s2, $0, $s1	#sofword = eofword
				j eofstr1
done1:			lw   $s0, 4($sp)  	# restore $ra
				lw   $s1, 8($sp)  	# restore $ra
				lw   $s2, 12($sp)  	# restore $ra
				lw   $ra, 0($sp)  	# restore $ra
				addi $sp, $sp, 16	# restore $sp
				jr $ra
reverse:		slt $t0, $a1, $a2	# (i > j)
				beq $t0, $0, end_rev
				add $t3, $a0, $a2	
				lb $t4, 0($t3) 		# array[i]
				add $t5, $a0, $a1
				lb $t6, 0($t5) 		# array[i]
				sb $t4, 0($t5)
				sb $t6, 0($t3)
				addi $a2, $a2, -1	# i-1
				addi $a1, $a1, 1	# j+1
				j reverse
end_rev:		jr $ra
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			