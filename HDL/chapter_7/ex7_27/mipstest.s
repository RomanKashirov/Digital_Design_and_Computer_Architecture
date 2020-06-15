# mipstest.asm
# David_Harris@hmc.edu, Sarah_Harris@hmc.edu 31 March 2012
#
# Тест процессора MIPS 
# add, sub, and, or, slt, addi, lw, sw, beq, j, bne
# Если успешно, по адресу 84 запишется 7
#         Assembly               Description                       Address   Machine
main:     addi  $2, $0,  5       # задать $2 = 5                   0         20020005
          addi  $3, $0, 12       # задать $3 = 12                  4         2003000c
          addi  $7, $3, -9       # задать $7 = 3                   8         2067fff7
          or    $4, $7, $2       # $4 = (3 OR 5) = 7               c         00e22025
          and   $5, $3, $4       # $5 = (12 AND 7) = 4             10        00642824
          add   $5, $5, $4       # $5 = 4 + 7 = 11                 14        00a42820
          beq   $5, $7, end      # не брать                        18        10a7000a
          slt   $4, $3, $4       # $4 = 12 < 7 = 0                 1c        0064202a
          beq   $4, $0, around   # брать                           20        10800001
          addi  $5, $0,  0       # не должно случиться             24        20050000
around:   slt   $4, $7, $2       # $4 = 3 < 5 = 1                  28        00e2202a
          add   $7, $4, $5       # $7 = 1 + 11 = 12                2c        00853820
          sub   $7, $7, $2       # $7 = 12 – 5 = 7                 30        00e23822
          sw    $7, 68 ($3)      # [80] = 7                        34        ac670044
          lw    $2, 80 ($0)      # $2 = [80] = 7                   38        8c020050
          j     brnoteq          # брать                           3c        08000013
		  addi  $2, $0, 1        # не брать                        40        20020001
brnoteq:  bne	$2, $7, end		# не должен перескочить addi	   44
		  addi 	$2, $0, 2										   48
end:      sw    $2, 84($0)       # записать в память mem[84] = 9   4c        ac020054
