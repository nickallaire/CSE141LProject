# from bitstring import Bits

opcode = {
    'blt': 1,
    'beq': 2,
    'sl': 3,
    'sr': 4,
    'sro': 5,
    'set': 6,
    'sti': 7,
    'lw': 0,
    'sw': 0,
    'add': 0,
    'comp': 0,
    'mov': 0,
    'j': 0,
    'clr': 0,
    'halt': 0
}

registers = {
    'r0': 0,
    'r1': 1,
    'r2': 2,
    'r3': 3,
    'r4': 4,
    'r5': 5,
    'r6': 6,
    'r7': 7,
    'r8': 2,
    'r9': 3,
    'r10': 4,
    'r11': 5,
    'r12': 6,
    'r13': 7,
    'r14': 2,
    'r15': 3
}

# look up table
labels = {
    # 'mainloop': 0,  # Cordic
    # 'else': 1,
    # 'goUp3': 2,
    # 'done_if': 3,
    # 'loop1': 4,
    # 'ltfive1': 5,
    # 'done1': 6,
    # 'goUp2': 7,
    # 'loop2': 8,
    # 'ltfive2': 9,
    # 'done2': 10,
    # 'goUp1': 11,
    # 'after1': 12,
    # 'if': 13,
    # 'end_if1': 14,

    'eq': 17,  # string pattern
    'loop1': 18,
    'eq1': 19,
    'noteq': 20,
    'done': 21,

    'loop': 22,  # division
    'if1': 23,
    'else2': 24,
    'endif': 25,
    'back': 26,
    'check': 27
}


def assembleMachineCode(words, outFile):
    # print "OPCODE =", words[0]

    if len(words) == 0:
        return

    if words[0] not in opcode:
        return

    wordCount = len(words)

    if wordCount == 1:
        op = opcode[words[0]]
        outFile.write(format(op, 'b').zfill(6))
        if words[0] == "halt":
            func = 0
        elif words[0] == "j":
            func = 6
        else:  # clear
            func = 7
        outFile.write(format(func, 'b').zfill(3))

    elif wordCount == 2:
        op = opcode[words[0]]
        outFile.write(format(op, 'b').zfill(3))
        if op == 0:
            if words[0] == "lw":
                func = 1
            elif words[0] == "sw":
                func = 2
            elif words[0] == "add":
                func = 3
            elif words[0] == "comp":
                func = 4
            else:
                func = 5

            outFile.write(format(registers[words[1]], 'b').zfill(3))
            outFile.write(format(func, 'b').zfill(3))

        else:  # set
                if words[1] in labels:  # label
                    label = labels[words[1]]
                    outFile.write(format(label, 'b').zfill(6))
                else:
                    outFile.write(format(int(words[1]), 'b').zfill(6))

    else:  # wordCount == 3
        op = opcode[words[0]]
        outFile.write(format(op, 'b').zfill(3))

        if words[0] == "sti":
            reg = registers[words[1]]
            outFile.write(format(reg, 'b').zfill(3))
            outFile.write(format(int(words[2]), 'b').zfill(3))

        else:
            reg1 = registers[words[1]]
            reg2 = registers[words[2]]
            outFile.write(format(reg1, 'b').zfill(3))
            outFile.write(format(reg2, 'b').zfill(3))

    outFile.write("		//")
    for w in words:
        outFile.write(w + " ")
    outFile.write("\r\n")


if __name__ == "__main__":
    print("START!!\n")
    with open('string_pattern.s') as inputFile:
        with open('string_instr.txt', 'w') as outputFile:
            lineCount = 1
            for line in inputFile:
                print "Assembling line %d" % lineCount
                code = line.split()
                for word in code:
                    print word
                assembleMachineCode(code, outputFile)
                lineCount += 1
