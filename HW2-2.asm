#     When Harry Met Sally
#
#
# This program finds the earliest point at which Harry and Sally lived in the
# same city.
#
#  required output register usage:
#  $2: earliest year in same city
#
# <09/06/2015>                  <Alizain Charania>

#$4 : Harry first word
#$6 : Sally first word
#$5 : initialize 4
#$7 : condition tester
#$8 : begin point
#$9 : end point (2015)
#$10: i
#$11: j
#$12: hCity
#$13: sCity
#$14: Year
#$15: condition tester
#$16: condition tester
#$17: condition tester
#$18: Harry vector
#$19: Harry year
#$20: Sally vector
#21: Sally year

.data
Harry:  .alloc  10                  # allocate static space for 5 moves
Sally:  .alloc  10                  # allocate static space for 5 moves

.text
WhenMet:    addi  $1, $0, Harry       # set memory base
            swi   586                 # create timelines and store them
            
            addi  $5, $0, 4           #initialize the first word of Harry and Sally
            lw    $4, Harry($0)       #load the first word of Harry
            lw    $6, Sally($0)       #load the first word of Sally
            addi  $9, $0, 2016        #end = 2016
            addi  $10, $0, 0          #i = 0
            addi  $11, $0, 0          #j = 0
            addi  $12, $0, -2         #hCity = -2
            addi  $13, $0, -1         #sCity = -1
            addi  $14, $0, 0          #Year = 0

            slt   $7, $4, $6          #HarryFirst < SallyFirst
            beq   $7, $0, Else1       #$7 == 0, then branch
            add   $8, $0, $4          #begin = HarryFirst
            j     Loop                #jump to Loop

Else1:      add   $8, $0, $6          #begin = SallyFirst

Loop:       slt   $15, $8, $9         #begin < end(2016)
            slti  $16, $14, 1         #Year < 1
            and   $17, $15, $16       #begin < end && Year<1
            beq   $17, $0, End        #condition false, then End it

If1:        lw    $18, Harry($10)     #load Harry vector
            bne   $8, $18, If2        #if (begin == HarryTimeline[i])
            addi  $19, $10, 4         #i = i+1
            lw    $12, Harry($19)     #hCity = HarryTimeline[ind1]
            addi  $10, $10, 8         #i = i+2

If2:        lw    $20, Sally($11)     #load Sally vector
            bne   $8, $20, If3        #if (begin == SallyTimeline[i])
            addi  $21, $11, 4         #j = j+1
            lw    $13, Sally($21)     #hCity = SallyTimeline[ind1]
            addi  $22, $0, 32
            beq   $11, $22, If3
            addi  $11, $11, 8         #j = j+2

If3:        bne   $12, $13, Next      #if (hCity == sCity)
            add   $14, $0, $8          #Year = begin

Next:       addi  $8, $8, 1           #begin++
            j     Loop

End:        add   $2, $0, $14         # assigning the answer
            swi   587                 # give answer

            jr    $31                 # return to caller
