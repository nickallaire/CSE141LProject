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

set check
j

back:
// Check if divisor < div 
set if1
beq r4 r7

set else2
blt r7 r4

set if1
j

check:
// Check if MSW of div == 0
set 0
mov r5
set back
beq r5 r6

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
