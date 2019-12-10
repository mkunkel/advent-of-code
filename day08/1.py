#! /usr/bin/env python3
def sort_order(val):
    # print(val)
    return val.count('0')

def divide_chunks(lst, length):
    # looping till length l
    for i in range(0, len(lst), length):
        yield lst[i:i + length]


file = open("day08/input.txt", "r")
input = file.read().rstrip()
file.close()

layers = list(divide_chunks([char for char in input], 25 * 6))
# layers = list(divide_chunks(lines, 6))

layers.sort(key = sort_order)
layers = list(layers)
checksum = layers[0].count('1') * layers[0].count('2')

print(checksum)
