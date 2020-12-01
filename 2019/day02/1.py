#! /usr/bin/env python3

def chunks(codes, size):
    for code in range(0, len(codes), size):
        yield codes[code:code + size]

def process(codes):
    ops = chunks(codes, 4)

    for op in ops:
        if op[0] == 1:
            before = codes[op[3]]
            codes[op[3]] = codes[op[1]] + codes[op[2]]
        elif op[0] == 2:
            codes[op[3]] = codes[op[1]] * codes[op[2]]
        elif op[0] == 99:
            print(codes[0])
            exit()
    print(codes)

file = open("day02/input.txt", "r")
codes = file.read().split(",")
codes = list(map(int, codes))

codes[1] = 12
codes[2] = 2


process(codes)
