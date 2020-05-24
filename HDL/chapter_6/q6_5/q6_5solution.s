# Question 6.5 solution
# $t0 - i, $v0 - result $t5 = 31
main:			addi $sp, $sp, -4 	# make room on stack
				sw   $ra, 0($sp)  	# store $ra
				lui $t3, 0xF00       # 
				ori $t3, $t3, 0x0000  #
				
								# $t3 = num
				addi $a0, $t3, 0      # set up args
				addi $a1, $0, 1
				li   $a2, 0x55555555
				jal  swap             # swap bits
				addi $a0, $v0, 0      # num = return value
				addi $a1, $0, 2       # set up args
				li   $a2, 0x33333333
				jal  swap             # swap pairs
				addi $a0, $v0, 0      # num = return value
				addi $a1, $0, 4       # set up args
				li   $a2, 0x0F0F0F0F
				jal  swap             # swap nibbles
				addi $a0, $v0, 0      # num = return value
				addi $a1, $0, 8       # set up args
				li   $a2, 0x00FF00FF
				jal  swap             # swap bytes
				addi $a0, $v0, 0      # num = return value
				addi $a1, $0, 16      # set up args
				li   $a2, 0xFFFFFFFF
				jal  swap             # swap halves
				addi $t3, $v0, 0      # num = return value
				 
				lw   $ra, 0($sp)  	# restore $ra
				addi $sp, $sp, 4	# restore $sp
				jr $ra
swap:
				  srlv $v0, $a0, $a1  # $v0 = num >> shamt
				  and  $v0, $v0, $a2  # $v0 = $v0 & mask
				  and  $t0, $a0, $a2  # $t0 = num & mask
				  sllv $t0, $t0, $a1  # $t0 = $t0 << shamt
				  or   $v0, $v0, $t0  # $v0 = $v0 | $t0
				  jr   $ra            # return
				
				
				
				
				











rev_done:		jr $ra
