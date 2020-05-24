# Question 6.6 Версия для отбитых 
# define the masks in the global data segment

						.data
				hbit:  .word 0x80000000
				lmask:  .word 0x7FFFFFFF
				
						.text
						
main:			addi $sp, $sp, -4 	# make room on stack
				sw   $ra, 0($sp)  	# store $ra
				
				lui $a0, 0xF00        
				ori $a0, $a0, 0x0000 # a
				
				lui $a1, 0xF00        
				ori $a1, $a1, 0x0000 # b  
				
				jal check_overflow
				
				lw   $ra, 0($sp)  	# restore $ra
				addi $sp, $sp, 4	# restore $sp
				jr $ra

check_overflow: lw $t0, hbit            # load 31 bit mask
				lw $t1, lmask            # load 30:0 bits mask
				and $t2, $a0, $t0		# (a&0x80000000)
				and $t3, $a1, $t0		# (b&0x80000000)
				and $t4, $t2, $t3 		# (a&0x80000000)&(b&0x80000000)
				or $t2, $t2, $t3		# (a&0x80000000)|(b&0x80000000)
				and $t3, $a0, $t1		# (a&0x7FFFFFFF)
				and $t1, $a1, $t1		# (b&0x7FFFFFFF)
				add $t1, $t1, $t3		# (a&0x7FFFFFFF)+(b&0x7FFFFFFF)
				and $t1, $t1, $t0		# ((a&0x7FFFFFFF)+(b&0x7FFFFFFF))&0x80000000
				and $t1, $t1, $t2		# ((a&0x80000000)|(b&0x80000000)) & ( ((a&0x7FFFFFFF)+(b&0x7FFFFFFF))&0x80000000) )
				or $t1, $t1, $t4		# ((a&0x80000000)&(b&0x80000000)) | (((a&0x80000000)|(b&0x80000000)) & ( ((a&0x7FFFFFFF)+(b&0x7FFFFFFF))&0x80000000) )
				























