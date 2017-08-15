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