# Question 6.7 solution
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

# $t0 = j, $t1 = i, $a0 = base address of string
		palindrome:
				addi $t0, $0, 0      # j = 0
		length: add  $t2, $a0, $t0   # $t2 = &array[j]
				lb   $t2, 0($t2)     # $t2 = array[j]
				beq  $t2, $0, done   # end of string?
				addi $t0, $t0, 1     # j = j+1
				j    length
		done:   addi $t0, $t0, -1    # j = j-1
				addi $t1, $0, 0       # i = 0
		loop:   slt  $t2, $t1, $t0    # $t2 = 1 if i < j
				beq  $t2, $0,  yes    # if !(i < j) return
				add  $t2, $a0, $t1    # $t2 = &array[i]
				lb   $t2, 0($t2)      # $t2 = array[i]
				add  $t3, $a0, $t0    # $t3 = &array[j]
				lb   $t3, 0($t3)      # $t3 = array[j]
				bne  $t2, $t3, no     # is palindrome?
				addi $t0, $t0, -1     # j = j-1
				addi $t1, $t1, 1      # i = i+1
				j    loop
		yes:    # yes a palindrome
				addi $v0, $0, 1
				jr   $ra
		no:     # not a palindrome
				addi $v0, $0, 0
				jr   $ra
