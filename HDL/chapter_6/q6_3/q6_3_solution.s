# Question 6.3 solution
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
				jal reversewords
				
				lw   $ra, 12($sp)  	# restore $ra
				addi $sp, $sp, 16	# restore $sp
				jr $ra

# $s2 = i, $s3 = j, $s1 = length
reversewords:
        addi $sp, $sp, -16   # make room on stack
        sw   $ra, 12($sp)    # store regs on stack
        sw   $s1, 8($sp)
        sw   $s2, 4($sp)
        sw   $s3, 0($sp)
        addi $s2, $0, 0      # i = 0
length: add  $t4, $a0, $s2   # $t4 = &array[i]
        lb   $t3, 0($t4)     # $t3 = array[i]
        beq  $t3, $0, done   # end of string?
        addi $s2, $s2, 1     # i++
        j    length
done:   addi $s1, $s2, 0     # length = i
        addi $a1, $s1, -1    # $a1 = length - 1
        addi $a2, $0, 0      # $a2 = 0
        jal  reverse         # call reverse
        addi $s2, $0, 0      # i = 0
        addi $s3, $0, 0      # j = 0
        addi $t5, $0, 0x20   # $t5 = “space”
word:   slt  $t4, $s1, $s2   # $t4 = 1 if length<i
        bne  $t4, $0, return # return if length<i
        beq  $s2, $s1, else  # if i==length, else
        add  $t4, $a0, $s2   # $t4 = &array[i]
        lb   $t4, 0($t4)     # $t4 = array[i]
        beq  $t4, $t5, else  # if $t4==0x20,else
        addi $s2, $s2, 1     # i = i + 1
        j    word
else:   addi $a1, $s2, -1    # $a1 = i - 1
        addi $a2, $s3, 0     # $a2 = j
        jal  reverse
        addi $s2, $s2, 1     # i = i + 1
        addi $s3, $s2, 0     # j = i
        j    word
return: lw   $ra, 12($sp)    # restore regs
        lw   $s1, 8($sp)
        lw   $s2, 4($sp)
        lw   $s3, 0($sp)
        addi $sp, $sp, 16    # restore $sp
        jr   $ra             # return
reverse:
        slt  $t0, $a2, $a1    # $t0 = 1 if j < i
        beq  $t0, $0,  exit   # if j < i, return
        add  $t1, $a0, $a1    # $t1 = &array[i]
        lb   $t2, 0($t1)      # $t2 = array[i]
        add  $t3, $a0, $a2    # $t3 = &array[j]
        lb   $t4, 0($t3)      # $t4 = array[j]
        sb   $t4, 0($t1)      # array[i] =array[j]
        sb   $t2, 0($t3)      # array[j] =array[i]
        addi $a1, $a1, -1     # i = i-1
        addi $a2, $a2, 1      # j = j+1
        j    reverse
exit:   jr  $ra
