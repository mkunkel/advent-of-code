#! /usr/bin/env python3
#! /usr/bin/env python3
def sort_order(val):
    # print(val)
    return val.count('0')

def divide_chunks(lst, length):
    # looping till length l
    for i in range(0, len(lst), length):
        yield lst[i:i + length]

def color_mapping(number_string):
    return { '0': '█', '1': '▒', '2': ' ' }[number_string]

file = open("day08/input.txt", "r")
input = file.read().rstrip()
file.close()

layers = list(divide_chunks([char for char in input], 25 * 6))
chars = [list(a) for a in zip(*layers)]


# rows = [[] for _i in range(6)]

# for layer in layers:
    # for row in layer:
output = []

for char in chars:
    for c in char:
        if c != '2':
            output.append(color_mapping(c))
            break

rows = list(divide_chunks([char for char in output], 25))

for row in rows:
    print(''.join(row))
