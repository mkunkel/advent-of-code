#! /usr/bin/env python

def chunks(codes, size):
    for code in range(0, len(codes), size):
        yield codes[code:code + size]

def process(n, v):
    file = open("day02/input.txt", "r")
    codes = file.read().split(",")
    codes = map(int, codes)

    codes[1] = n
    codes[2] = v

    ops = chunks(codes, 4)

    for op in ops:
        if op[0] == 1:
            before = codes[op[3]]
            codes[op[3]] = codes[op[1]] + codes[op[2]]
        elif op[0] == 2:
            codes[op[3]] = codes[op[1]] * codes[op[2]]
        elif op[0] == 99 and op[1] <= 0:
            return codes[0]
    return codes[0]


numbers = range(0, 99)

for noun in numbers:
    for verb in numbers:
        value = process(noun, verb)

        if value == 19690720:
            print "Value: %s" % value
            print "Noun: %s" % noun
            print "Verb: %s" % verb
            print "Total: %s" % str(100 * noun + verb)
