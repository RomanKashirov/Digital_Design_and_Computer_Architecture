# Exercise 6.22
# Fibonacci numbers
# $a0 = number
# $t0 = result
# $t1 = x
# $t2 = i# $t3 = flag = ( i < n )

main:
addi $sp, $sp, -4  # выделить место в стеке
sw   $ra, 0($sp)   # сохранить $ra
addi $a0, $0, 12
jal fib
lw   $ra, 0($sp)   # восстановить $ra
 addi $sp, $sp, 4   # восстановить $sp
jr $ra

fib:
addi $t0, $0, 1     	# result = 1
add $t1, $0, $0			# x = 0
addi $t2, $0, 1		# i = 1

bne $a0, $0, else   # if ( n == 0 )
add $v0, $0, $0		#  result = 0
jr   $ra           	#  return to caller

else:
bne $a0, $t0, loop   # if ( n == 1 )
addi $v0, $0, 1		#  result = 1
jr   $ra           	#  return to caller


loop:
slt $t3, $t2, $a0	# i < n ?
beq $t3, $0, done   # no goto done
add $t0, $t0, $t1   # result = result + x
sub $t1, $t0, $t1 	# x = result - x
addi $t2, $t2, 1		# i++
j loop

done:
add $v0, $0, $t0 		# return result
add $v0, $0, $t0 		# return result
add $v0, $0, $t0 		# return result
jr   $ra           	#  return to caller