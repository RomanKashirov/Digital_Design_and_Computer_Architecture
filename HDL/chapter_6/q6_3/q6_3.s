# Question 6.3 
# Hello world
# 0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x20, 0x77, 0x6F, 0x72 , 0x6C, 0x64, 0x00
 
main:		addi $sp, $sp, -16 	# make room on stack
			sw   $ra, 12($sp)  	# store $ra
			
			lui $t0, 0x6C6C       # 
			ori $t0, $t0, 0x6548  # 
			sw   $t0, 0($sp)  	# store Hell
			
			lui $t0, 0x6F77       # 
			ori $t0, $t0, 0x206F  # 
			sw   $t0, 4($sp)  	# store o wo
			
			lui $t0, 0x0064       # 
			ori $t0, $t0, 0x6C72  # 
			sw   $t0, 8($sp)  	# store rld
			add $a0, $0, $sp
			jal shitty_func
			
			lw   $ra, 12($sp)  	# restore $ra
			addi $sp, $sp, 16	# restore $sp
			jr $ra

shitty_func:
			addi $sp, $sp, -4 	# make room on stack
			sw   $ra, 0($sp)  	# store $ra
			
			add $t0, $0, $0		# int eofstr = 0;
			add $t1, $0, $0		# int eofword = 0;
			add $t2, $0, $0		# int sofword = 0;
			
eofstr:
			add $t3, $t0, $a0 			
			lb $t4, 0($t3) 
			beq $t4, $0, done
			addi $t0, $0, 1
			j eofstr
done:		add $a1, $0, $0
			addi $a2, $t0, -1
			jal reverse
			
eofstr1:	add $t3, $t1, $a0 			
			lb $t4, 0($t3) 
			beq $t4, $0, done1
			
			
			
			
			
			
done1:			
			
			


			
			lw   $ra, 0($sp)  	# restore $ra
			addi $sp, $sp, 4	# restore $sp
			jr $ra