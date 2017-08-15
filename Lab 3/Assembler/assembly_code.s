//Cordic Code:

// mem 0x01 MSW X
// mem 0x02 LSW X
// mem 0x03 MSW Y
// mem 0x04 LSW Y
// mem 0x05 MSW R
// mem 0x06 LSW R
// mem 0x07 MSW Theta
// mem 0x08 LSW Theta

// Registers initially 0
// ov - overflow
// r0 - Implicit accumulator

// BLOCK 0
// r1 - Implicit reg index
// r2 - index of loop
// r3 - X MSW
// r4 - X LSW
// r5 - X_temp MSW
// r6 - X_temp LSW
// r7 - temp

// BLOCK 1
// r8 - Y MSW
// r9 - Y LSW
// r10 - Y_temp MSW
// r11 - Y_temp LSW
// r12 - temp
// r13 - temp

// BLOCK 2
// r14 - T MSW
// r15 - T LSW
// others - temp

// load in X
set 1
lw r3
lw r5
set 2
lw r4
lw r6

// load in Y
sti r1 1
set 3
lw r8
lw r10
set 4
lw r9
lw r11

mainloop:
// y >= 0

// fix this
sl r8 r0
// fix this
sro r8 r0

set 1
mov r12
set 0
add r13
mov r13
clr
set else
beq r12 r13

sti r1 0
comp r5
sti r7 1
comp r7
set 0
add r5
add r7
mov r5
clr

comp r6
set 0
add r5
mov r5
clr
set done_if
j

else:
sti r1 1
comp r10
sti r12 1
comp r12
set 0
add r10
add r12
mov r10
clr

comp r11
set 0
add r10
mov r10
clr

// on the way back up to mainloop
set done_if
j
goUp3:
set mainloop
j

done_if: // let r12 be the index
// y_temp >>> i
sti r1 0
set 0
add r2

// fix this
sti r11 0
mov r12

set 5
mov r13
set ltfive1
blt r12 r13

// i >= 5
loop1:
set 1
mov r13
sr r10 r13
sro r11 r13
clr
comp r13
set 0
add r12
add r13
mov r12
clr

sti r13 0
set loop1
blt r13 r12
set done1
j

// i < 5
ltfive1:
sr r10 r12
sro r11 r12
clr

done1:
// x_new = ......
set 0
add r11
sti r1 0
add r4
mov r4
clr
sti r1 1
set 0
add r10
clr
sti r1 0
add r3
mov r3
clr

// x_temp >> i
// store i in r12
set 0
add r2
sti r1 1
mov r12
sti r1 0

set 5
mov r7
set ltfive2
blt r2 r7

// Going up to the mainloop
set loop2
j
goUp2:
set goUp3
j

// i >= 5
loop2:
set 1
mov r7
sr r5 r7
sro r6 r7
clr

// decrement
comp r7
set 0
add r2
add r7
mov r2
clr

sti r7 0
set loop2
blt r7 r2
set done2
j

// i < 5
ltfive2:
sr r5 r2
sro r6 r2
clr

done2:
// y_new = ......
set 0
add r6
sti r1 1
add r9
mov r9
clr
sti r1 0
set 0
add r5
clr
sti r1 1
add r8
mov r8
clr

// t_new = ...
// put index back inro r2
set 0
add r12
sti r1 0
mov r2

// load in T to Y_Temp
sti r1 2
set 0
add r14

// fix this
sti r11 0
mov r10

// fix this
sti r12 0
set 0
add r15
sti r1 1
mov r11

set 8
mov r13
set if
blt r12 r13
// i >= 8
set 16
mov r13

// on the way up to the main loop label...
set after1
j 
goUp1:
set goUp2
j

after1:
set 11
comp r12
clr
add r12

sl r13 r0
comp r13
clr

// addition
set 1
mov r12
comp r12

set 0
add r11
add r13
mov r11
set 0
add r12
clr
add r10
mov r10
clr

set end_if1
j

if: // i < 8
set 1
mov r13

set 7
comp r12
clr
add r12

sl r13 r0
comp r13
clr

// addition
set 0
add r13
add r10
mov r10
clr

end_if1:
// put t back
sti r1 2
mov r14
sti r1 1
set 0
add r11
sti r1 2
mov r15

// fill y_temp

// fix this
sti r11 0
set 0
add r8
mov r10
set 0
add r9
mov r11

// fill x_temp

// fix this
sti r10 0
set 0
add r3
mov r5
set 0
add r4
mov r6

// branch back
set 14
mov r7
set goUp1
blt r4 r7

// load values into memory

// r = x_temp
set 5
sw r5
set 6
sw r6

// t = t_temp
sti r1 2
set 7
sw r14
set 8
sw r15

halt





// String Pattern Code:

// mem 0x20 - 0x5F words
// mem 0x09 pattern
// mem 0x0A count

// risters initially 0
// ov - overflow
// r0 - implicit accumulator reg

// BLOCK 0
// r1 - implicit reg index
// r2 - pattern
// r3 - word
// r4 - temp reg to compare to pattern
// r5 - count

// BLOCK 1
// r8 - address of next word
// r9 - index i
// r10 - index j
// others - temp

// load in pattern
set 9
lw r2

// load in 1st word
set 32
lw r3

sti r1 1
mov r8

st1 r1 0
// 1st iteration
// load 4 MSB into temp reg
set 4
sl r2 r0
set 0
add r4
mov r4
clr

// count++ if match
set inc
beq r2 r4

set else
j

inc:
set 1
add r5
mov r5

// j = 4 continue matching pattern in innerloop for 1st word
else:
sti r1 1
set 4
mov r10
set innerloop
j

outerloop:
// load in next word
sti r1 1
set 8
add r8 r0
mov r8
sti r1 0
lw r3

////

// do all compares for 1 word
innerloop:
// sl temp and word by 1
sti r1 0
set 1
sl r4 r0
sl r3 r0

// add MSB word to LSB temp
add r4
mov r4

// clear leftmost 4 bits of temp
set 4
sl r4 r0
clr
sro r4 r0

// compare the temp and pattern
set inc2
beq r2 r4

endinner: 
// j++

// fix this
sti r11 0
set 1
add r10 r0
mov r10

// loop if j < 8
set 8
mov r11
set innerloop
blt r10 r11
set end
j

inc2:
// count++
set 1
add r5 r0
mov r5
clr
set endinner
j

end:
// i++
set 1
add r9
mov r9

// i < 63 outerloop again
set 63
mov r11
set outerloop
blt r9 r11

sti r1 0
set 10
sw r5
halt





// Signed Integer Division Code:

// mem 0x7E - 0x7F quotient
// mem 0x80 - 0x81 dividend
// mem 0x82 divisor

// Registers initially 0
// ov - overflow
// r0 - implicit accumulator reg
// r1 - Implicit register index

// BLOCK 0
// r2 - dividend MSW
// r3 - divident LSW
// r4 - divisor
// r5 - temp
// r6 - temp MSW
// r7 - temp LSW

// BLOCK 1
// r8 - loop index
// r9 - quotient MSW
// r10 - quotient LSW

set 7
mov r7

set 1
sl r0 r7
lw r2

mov r5
clr
set 1
mov r7
add r5
lw r3

add r7
lw r4

set 0
mov r7

loop:

set 0
mov r1

// shift div left by 1
set 1
mov r5
sl r6 r5
sl r7 r5
set 0
add r6
mov r6
clr

// div << 1 dividend << 1 div + MSB_dividend
sl r2 r5
set 0
add r7
mov r7
sl r3 r5
set 0
add r2
mov r2
clr

// Check if MSW of div == 0
set 0
mov r5
set if1
blt r5 r6

// Check if divisor < div LSW
set else2
blt r4 r7

if1:
// div = div - divisor

// sign extend  -divisor
comp r4
set 2
mov r5
set 63
sl r0 r5
mov r5
set 3
add r5
mov r5

// div - divisor 
set 0
add r4
add r7
mov r7
set 0
add r6
clr
add r5
mov r6
clr
comp r4

// quotient << 1 add 1
set 1 
mov r1
sl r9 r1
sl r10 r1
set 0
add r9
mov r9
clr
set 1
add r10
mov r10
clr
set endif
j

else2:
set 1
mov r1
sl r9 r0
sl r10 r0
set 0
add r9
mov r9
clr

endif:
// increment index
set 1
add r8
mov r8
set 16
mov r11
set loop

// Check index
blt r8 r11

// store quotient
clr
set 63
add r0
sw r9
add r1
sw r10

halt
