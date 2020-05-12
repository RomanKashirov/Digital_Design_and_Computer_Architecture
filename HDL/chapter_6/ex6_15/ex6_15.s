 addi $t0, $0, 31
L1:
  srlv $t1, $a0, $t0
  andi $t1, $t1, 1
  slt $t1, $0, $t1
  sb $t1, 0($a1)
  addi $a1, $a1, 1
  addi $t0, $t0, -1
  bgez $t0, L1
  jr $ra