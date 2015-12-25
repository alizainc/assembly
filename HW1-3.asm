# HW1-3
# Student Name: Alizain Charania
# Date: 08/28/2015
#
# This program computes the difference in the frequency of
# boiling temperatures and the frequency of freezing temperatures in a
# set of 25 integers, Temps.

#$10: value 99
#$1: boiling freq
#$2: freezing freq
#$3: i
#$4: for loop branch condition
#$5: word count


.data
Temps:    .word 110, 5, 200, -73, 0
          .word 17, 9, -7, -3, 100
          .word 25, 242, -126, 108, -60
          .word 26, 8, 60, 27, 117,
          .word 8, 7, 33, 100, 125
FreqDiff: .alloc 1

.text
                addi   $10, $0, 99        #initialize $10 to 100
                addi   $1, $0, 0          #initialize the boiling frequencies
                addi   $2, $0, 0          #initialize the freezing frequencies
                addi   $3, $0, 0          #initialize the i used in for loop
                addi   $5, $0, 96         #initialize the word data

Loop:           slti   $4, $3, 25         #i < 25 condition
                beq    $4, $0, Result     #branch to exit if i>25
                addi   $3, $3, 1          #i++

                lw     $6, Temps($5)      #load the next word
                addi   $5, $5, -4         #next word
If:             slt    $7, $10, $6        #100 < freqDiff[i]
                beq    $7, $0, ElseIf     #$7 == 0 go to elseif
                addi   $1, $1, 1          #boil = boil + 1
                j      Loop

ElseIf:         slt    $8, $0, $6         #0 < freqDiff[i]
                bne    $8, $0, Else       #$8 != 0 go to else
                addi   $2, $2, 1          #freeze = freeze + 1
                j      Loop

Else:           j      Loop

Result:         sub    $9, $1, $2        #$9 = boil-freeze
                sw     $9, FreqDiff($0)  #FreqDiff = $9

Exit:           jr     $31                # return to OS