// String pattern

// mem 0x20 - 0x60 words
// mem 0x09 pattern
// mem 0x0A count

// Registers initially 0
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

set 9 // load in pattern
lw r2
set 32 // load in 1st word
lw r3

sti r1, 1
mov r8

st1, r1, 0
// 1st iteration
// load 4 MSB into temp reg
set 4
sl r2, r0
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

// j = 4, continue matching pattern in innerloop for 1st word
else:
sti r1, 1
set 4
mov r10
set innerloop
j

outerloop:
// load in next word
sti r1, 1
set 8
add r8, r0
mov r8
sti r1, 0
lw r3

////

// do all compares for 1 word
innerloop:
// sl temp and word by 1
sti r1, 0
set 1
sl r4, r0
sl r3, r0

// add MSB word to LSB temp
add r4
mov r4

// clear leftmost 4 bits of temp
set 4
sl r4, r0
clr
sro r4, r0

// compare the temp and pattern
set inc2
beq r2, r4

endinner: 
// j++
sti r1,1
set 1
add r10, r0
mov r10

// loop if j < 8
set 8
mov r11
set innerloop
blt r10, r11
set end
j

inc2:
// count++
set 1
add r5, r0
mov r5
clr
set endinner
j

end:
// i++
set 1
add r9
mov r9

// i < 63, outerloop again
set 63
mov r11
set outerloop
blt r9 r11

sti r1, 0
set 10
sw r5
halt