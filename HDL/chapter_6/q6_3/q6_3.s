# Question 6.3 
# Hello world
# 0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x20, 0x77, 0x6F, 0x72 , 0x6C, 0x64, 0x00
 
main:		addi $sp, $sp, -16 	# make room on stack
			sw   $ra, 12($sp)  	# store $ra
			
			lui $t0, 0x4865       # 
			ori $t0, $t0, 0x6C6C  # 
			sw   $t0, 0($sp)  	# store Hell
			
			lui $t0, 0x6F20       # 
			ori $t0, $t0, 0x776F  # 
			sw   $t0, 4($sp)  	# store o wo
			
			lui $t0, 0x726C       # 
			ori $t0, $t0, 0x6400  # 
			sw   $t0, 8($sp)  	# store rld
			
			lw   $ra, 12($sp)  	# restore $ra
			addi $sp, $sp, 16	# restore $sp
			jr $ra

