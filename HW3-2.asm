#     When Harry Met Sally
#
#
# This program finds the earliest point at which Harry and Sally lived in the
# same city.
#
#  required output register usage:
#  $2: earliest year in same city
#
# <09/20/2015>                  <Alizain Charania>

#$4 : Harry first word
#$6 : Sally first word
#$5 : initialize 4 (removed)
#$7 : condition tester (removed)
#$8 : condition tester/ begin point
#$9 : end point (2015)
#$10: i
#$11: j
#$12: hCity
#$13: sCity
#$14: Year (removed)
#$15: condition tester (removed)
#$16: condition tester (removed)
#$17: condition tester (removed)
#$18: Harry vector (removed)
#$19: Harry year (removed)
#$20: Sally vector (removed)
#21: Sally year (removed)

.data
Harry:  .alloc  10                  # allocate static space for 5 moves
Sally:  .alloc  10                  # allocate static space for 5 moves

.text
WhenMet:    addi  $1, $0, Harry       # set memory base
            swi   586                 # create timelines and store them
            
                                                   #O4
            lw    $4, Harry($0)       #load the first word of Harry
            lw    $6, Sally($0)       #load the first word of Sally
            addi  $9, $0, 2016        #end = 2016
            addi  $10, $0, 0          #i = 0
            addi  $11, $0, 0          #j = 0
            addi  $12, $0, -2         #hCity = -2
            addi  $13, $0, -1         #sCity = -1
            addi  $2, $0, 0           #O8 Year = 0
            addi  $22, $0, 36

            slt   $8, $4, $6          #O5 HarryFirst < SallyFirst
            beq   $8, $0, Else1       #O5 $8== 0, then branch
            add   $8, $0, $4          #begin = HarryFirst
            j     Loop                #jump to Loop

Else1:      add   $8, $0, $6          #begin = SallyFirst

Loop:       beq $8, $9, End           #O1 begin < end(2016)
                                      #O2 O9 Year < 1
                                      #O3

If1:        lw    $4, Harry($10)      #load Harry vector
            bne   $8, $4, If2         #if (begin == HarryTimeline[i])
            addi  $10, $10, 4         #O10 i = i+1
            lw    $12, Harry($10)     #O10 hCity = HarryTimeline[ind1]
            addi  $10, $10, 4         #BF2 i = i+2

If2:        lw    $6, Sally($11)      #O13 load Sally vector
            bne   $8, $6, If3         #O13 if (begin == SallyTimeline[i])
            addi  $11, $11, 4         #O11 j = j+1
            lw    $13, Sally($11)     #O11 hCity = SallyTimeline[ind1]
            beq   $11, $22, If3
            addi  $11, $11, 4         #BF3 j = j+2

If3:        bne   $12, $13, Next      #if (hCity == sCity)
                                      #O7 Year = begin
            j End1                    #O6 break

Next:       addi  $8, $8, 1           #begin++
            j     Loop

End1:       add   $2, $0, $8         # BF1 assigning the answer

End:        swi   587                 # give answer

            jr    $31                 # return to caller
