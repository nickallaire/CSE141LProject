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
// r5 - free
// r6 - address of next work
// r7 - index of current bit

// BLOCK 1
// r8 - free
// r9 - count
// r10 - free
// others - temp

// load in pattern
set 9
lw r2

// load in 1st word
set 32
lw r3

// load in next work index
set 33
mov r6

// get upper 4 bits of temp word
set 4
sl r3 r0
set 0
add r4
mov r4
clr

// initial index = 3
set 4
mov r7

// compare with pattern
set eq
beq r4 r2

// 1st compare failed
set loop1
j

// count ++
eq:
clr
set 1
mov r1
add r9
mov r9
clr
set 0
mov r1

loop1:
// shift temp by 1, load in next msb from word into temp
set 1
sl r4 r0 
sl r3 r0
set 0
add r4
mov r4
clr

// clear upper 4 bits of temp
set 4
sl r4 r0
sr r4 r0
clr

// compare pattern with temp
set eq1
beq r4 r2

set noteq
j

eq1:
set 1
mov r1
add r9
mov r9
clr
set 0
mov r1

// check if reached 255
set 1
mov r1
set 63
mov r8
set 2
sl r8 r0
clr
set 3
add r8
mov r8
clr
set done
beq r8 r9


noteq:
// increment index
set 0
mov r1
set 1
add r7
mov r7

// index < 8
set 8
mov r5
set loop1
blt r7 r5

// check if last word
set 48
mov r5
set 1
sl r5 r0
set done
beq r6 r5

// get next word
clr
set 0
add r6
lw r3

// increment next word index
clr
set 1
add r6
mov r6
clr

// set index to 0
set 0
mov r7
set loop1
j

done:
set 1
mov r1
set 10
sw r9
halt