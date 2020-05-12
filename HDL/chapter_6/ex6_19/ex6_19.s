# Exercise 6.19
# $a0 = dst array base address
# $a1 = src array base address
# $s1 = i

strcpy:
addi $sp, $sp, -4 	# make space on stack to store one register
sw $s0, 0($sp) 		# save $s0 on stack
add $s0, $0, $0     	# i = 0

loop:
add $t1, $a1, $s0 	# $t1 = address of src[i]
add $t2, $a0, $s0 	# $t2 = address of dst[i]
lb $t3, 0($t1)		# t3 = src[i]
sb $t3, 0($t2)		# dst[i] = t3
beq $t0, $0, done	# repeat if temp != 0
addi $s0, $s0, 1	# i++
j loop

done:
lw $s0, 0($sp) 		# restore $s0 from stack
addi $sp, $sp, 4 	# deallocate stack space
jr   $ra           	#  return to caller





  
