# Exercise 6.27 Solution
main:		addi $sp, $sp, -4  # make room on stack
			sw   $ra, 0($sp)   # store $ra
			addi $a0, $0, 3
			jal setArray
			lw   $ra, 0($sp)   # restore $ra
			addi $sp, $sp, 4   # restore $sp
			jr $ra
setArray:  addi $sp,$sp,-52    # move stack pointer
            sw   $ra,48($sp)   # save return address
            sw   $s0,44($sp)   # save $s0
            sw   $s1,40($sp)   # save $s1
            add  $s0,$0,$0     # i = 0
            addi $s1,$0,10     # max iterations = 10
     loop:  add  $a1,$s0,$0    # pass i as parameter
            jal  compare       # call compare(num, i)
            sll  $t1,$s0,2     # $t1 = i*4
            add  $t2,$sp,$t1   # $t2 = address of array[i]
            sw   $v0,0($t2)    # array[i] = compare(num, i);
            addi $s0,$s0,1     # i++
            bne  $s0,$s1,loop  # if i<10, goto loop
            lw   $s1,40($sp)   # restore $s1
            lw   $s0,44($sp)   # restore $s0
            lw   $ra,48($sp)   # restore return address
            addi $sp,$sp,52    # restore stack pointer
            jr   $ra           # return to point of call
  compare:  addi $sp,$sp,-4    # move stack pointer
            sw   $ra,0($sp)    # save return address on the stack
            jal  subtract      # input parameters already in $a0,$a1
            slt  $v0,$v0,$0    # $v0=1 if sub(a,b) < 0 (return 0)
            slti $v0,$v0,1     # $v0=1 if sub(a,b)>=0, else $v0 = 0 
            lw   $ra,0($sp)    # restore return address
            addi $sp,$sp,4     # restore stack pointer
            jr   $ra           # return to point of call
 subtract:  sub  $v0,$a0,$a1   # return a-b
            jr   $ra           # return to point of call
