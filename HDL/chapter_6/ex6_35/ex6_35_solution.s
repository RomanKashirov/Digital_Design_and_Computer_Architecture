# Exercise 6.35 solution
# define the masks in the global data segment
        .data
mmask:  .word 0x007FFFFF
emask:  .word 0x7F800000
ibit:   .word 0x00800000
obit:   .word 0x01000000
        .text
main:		addi $sp, $sp, -4 	# make room on stack
			sw   $ra, 0($sp)  	# store $ra
			lui  $a1, 0x4700       # $a1 = 0x47000000
			ori  $a1, $a1, 0x0000  # $a1 = 0x47000000 = 32768
			lui  $a0, 0x4049       # $a0 = 0x40490000
			ori  $a0, $a0, 0x0E56  # $a0 = 0х40490E56 = 3.1415
			jal add_floats 
			lw   $ra, 0($sp)  	# restore $ra
			addi $sp, $sp, 4	# restore $sp
			jr $ra
add_floats:	
flpadd: 
		add $s0, $0, $a0
		add $s1, $0, $a1
		lw $t4,mmask            # load mantissa mask
        and $t0,$s0,$t4         # extract mantissa from $s0 (a)
        and $t1,$s1,$t4         # extract mantissa from $s1 (b)
        lw $t4,ibit             # load implicit leading 1
        or $t0,$t0,$t4          # add the implicit leading 1 to mantissa
        or $t1,$t1,$t4          # add the implicit leading 1 to mantissa
		lw $t4,emask            # load exponent mask
        and $t2,$s0,$t4         # extract exponent from $s0 (a)
        srl $t2,$t2,23          # shift exponent right
        and $t3,$s1,$t4         # extract exponent from $s1 (b)
        srl $t3,$t3,23          # shift exponent right
match:  beq $t2,$t3,addsig      # check whether the exponents match
        bgeu $t2,$t3,shiftb     # determine which exponent is larger
shifta: sub $t4,$t3,$t2         # calculate difference in exponents
        srav $t0,$t0,$t4        # shift a by calculated difference
        add $t2,$t2,$t4         # update a's exponent
        j addsig                # skip to the add
shiftb: sub $t4,$t2,$t3         # calculate difference in exponents
        srav $t1,$t1,$t4        # shift b by calculated difference
        add $t3,$t3,$t4         # update b's exponent (not necessary)
addsig: add $t5,$t0,$t1         # add the mantissas
norm:   lw $t4,obit             # load mask for bit 24 (overflow bit)
        and $t4,$t5,$t4         # mask bit 24
        beq $t4,$0,done         # right shift not needed because bit 24=0
        srl $t5,$t5,1           # shift right once by 1 bit
        addi $t2,$t2,1          # increment exponent
done:   lw $t4,mmask            # load mask
        and $t5,$t5,$t4         # mask mantissa
        sll $t2,$t2,23          # shift exponent into place
        lw $t4,emask            # load mask
        and $t2,$t2,$t4         # mask exponent
        or $v0,$t5,$t2          # place mantissa and exponent into $v0
        jr $ra                  # return to caller

