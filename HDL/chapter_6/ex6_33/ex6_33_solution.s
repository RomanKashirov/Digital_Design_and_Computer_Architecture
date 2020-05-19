# Exercise 6.33
main:		addi $sp, $sp, -44 	# make room on stack
			sw   $ra, 40($sp)  	# store $ra
			add $t0, $0, $sp
			addi $t1, $0, 0
			addi $t2, $0, 10
			addi $t3, $0, 0x1234			
fill_array:	sw $t3, 0($t0)
			addi $t0, $t0, 4
			addi $t1, $t1, 1
			addi $t3, 0x7999
			bne $t1, $t2, fill_array
			add $a0, $0, $sp
			jal little2big
			lw   $ra, 40($sp)  	# restore $ra
			addi $sp, $sp, 44	# restore $sp
			jr $ra
little2big: 
            addi $t5, $0, 10  # $t5 = i = 10 (loop counter)
      loop: lb   $t0, 0($a0)  # $t0 = array[i] byte 0
            lb   $t1, 1($a0)  # $t1 = array[i] byte 1
            lb   $t2, 2($a0)  # $t2 = array[i] byte 2
            lb   $t3, 3($a0)  # $t3 = array[i] byte 3
            sb   $t3, 0($a0)  # array[i] byte 0 = previous byte 3
            sb   $t2, 1($a0)  # array[i] byte 1 = previous byte 2
            sb   $t1, 2($a0)  # array[i] byte 2 = previous byte 1
            sb   $t0, 3($a0)  # array[i] byte 3 = previous byte 0
            addi $a0, $a0, 4  # increment index into array
            addi $t5, $t5, -1 # decrement loop counter
            beq  $t5, $0, done
            j    loop
      done:
			jr $ra
