# a

slt $t0, $s1, $s0
blez $t0, else
add $S0, $S0, $S1
j done
else:
sub $S0, $S0, $S1
done:
 

# b

slt $t0, $s0, $s1
bgtz $t0, else
addi $S0, $S0, 1
j done
else:
addi $S1, $S1, -1
done:


# c

slt $t0, $s1, $s0
bgtz $t0, else
add $s0, $0, $0
j done
else:
sub $s1, $0, $0
done:

