#    Find George Possibly Incognito in a Crowd
#
#
# This routine finds an exact match of George's face (possibly incognito)
# in a crowd.
#
# <10/12/2015>                               <Alizain Charania>

#$1 -  used as the counter from the Array base position (i)
#$2 -  value of the Location/ the byte loaded from the Array
#$7 -  black color (8)
#$8 -  blue color (3) 
#$12-  red color (2)/green color (7)/temporary conditional/white color (1)/yellow color (5)/also re-used as currentIncreament

.data
Array:  .alloc  1024

.text

FindGeorge: addi    $1, $0, Array       # point to array base
            swi 588         # generate crowd

            # your code goes here
            
            addi    $7, $0, 8           #initialzing the black color check
            addi    $8, $0, 3           #initialzing the blue color check

AddOne:     addi    $1, $1, 4           #i++
While:      lbu     $2, 0($1)           #crowd[i] where crowd is a 4096 sized array
Black:      bne     $2, $7, Blue        #if crowd[i] != 8, Blue

InnerBlack: addi    $1, $1, -1          #check the previous pixel
            lbu     $2, 0($1)           #load previous pixel 
            slt     $12, $7, $2         #if 8 < pixel
            bne     $12, $0, CheckBlack #get to the CheckBlack
            j       InnerBlack

CheckBlack: addi    $1, $1, 1           #the left-most hat pixel

            lbu     $2, 321($1)       #crowd[j]
            bne     $2, $8, AddSix      #crowd[j] != 3, AddSix 

            lbu     $2, 450($1)       #crowd[j]
            bne     $2, $7, AddSix      #crowd[j] != 8, AddSix

            lbu     $2, 705($1)       #crowd[j]
            bne     $2, $7, AddSix      #crowd[j] != 8, AddSix

            addi    $12, $0, 5          #color yellow
            lbu     $2, 449($1)       #crowd[j]
            bne     $2, $12, AddSix     #crowd[j] != 5, AddSix

            addi    $12, $0, 1          #color white
            lbu     $2, 193($1)         #crowd[j]
            bne     $2, $12, AddSix      #crowd[j] != 1, AddSix

            j       End                 #Location found, End

Blue:       bne     $2, $8, Background  #if crowd[i] != 3, Background color

InnerBlue:  addi    $1, $1, -1          #check the previous pixel
            lbu     $2, 0($1)          #load previous pixel
            slt     $12, $7, $2         #if 8 < pixel
            bne     $12, $0, CheckBlue #get to the CheckBlack 
            j       InnerBlue

CheckBlue:  addi    $1, $1, 1           #the ledt-most hat pixel

            addi    $12, $0, 7          #color green
            lbu     $2, 320($1)         #crowd[i = 320]
            bne     $2, $12, AddSix     #if crowd[i + 320] != 7, AddSix

            lbu     $2, 704($1)         #crowd[i + 704]
            bne     $2, $8, AddSix      #crowd[i + 704] != 3, AddSix

            addi    $12, $0, 2          #color red
            lbu     $2, 448($1)         #crowd[i + 448]
            bne     $2, $12, AddSix     #if crowd[i + 448] != 2, AddSix

            addi    $12, $0, 5          #color yellow
            lbu     $2, 321($1)         #crowd[i + 512]
            bne     $2, $12, AddSix     #if crowd[i + 512] != 5, AddSix

            addi    $12, $0, 1          #color white
            lbu     $2, 193($1)         #crowd[i + 193]
            bne     $2, $12, AddSix      #if crowd[i + 193] != 1, AddSix

            j       End                 #Location found, End

Background: slt     $12, $7, $2         #if 8 < pixel
            bne     $12, $0, AddOne     #get to the CheckBlack 

AddSix:     addi    $1, $1, 11          #i += 6
            j       While               #jump to while loop


End:        addi    $12, $0, Array      #getting the location of Array
            sub     $2, $1, $12         #currentIncreament = currentLocation - base
            addi    $2, $2, 3           #Location = currentIncreament + 3

            swi 553         # submit answer and check
            jr  $31         # return to caller
