#! /usr/bin/env python3

def process(input_id):
    file = open("day05/input.txt", "r")
    codes = file.read().split(",")
    file.close()

    codes = list(map(int, codes))

    next_instruction(codes, 0, input_id)

def next_instruction(codes, pointer, input_id):
    instruction = to_instruction(codes, pointer, input_id)

    if instruction['opcode'] == 99:
        return codes

    result = eval("code_{0}({1},{2})".format(instruction["opcode"], codes, instruction))
    next_instruction(result["codes"], result["pointer"], input_id)


def to_instruction(codes, pointer, input_id):
    number = codes[pointer]
    pointer += 1

    extended = str(number).rjust(5, '0')
    return {
        "mode_3": int(extended[0]),
        "mode_2": int(extended[1]),
        "mode_1": int(extended[2]),
        "opcode": int(extended[3:5]),
        "pointer": pointer,
        "input_id": input_id
    }

def code_1(codes, instruction):
    print('1')
    noun = codes[instruction["pointer"]]
    verb = codes[instruction["pointer"] + 1]
    pos = codes[instruction["pointer"] + 2]
    instruction["pointer"] += 3

    noun = codes[noun] if instruction["mode_1"] == 0 else noun
    verb = codes[verb] if instruction["mode_2"] == 0 else verb
    pos = codes[pos] if instruction["mode_3"] == 1 else pos

    codes[pos] = noun + verb
    return { "codes": codes, "pointer": instruction["pointer"] }

def code_2(codes, instruction):
    print('2')
    noun = codes[instruction["pointer"]]
    verb = codes[instruction["pointer"] + 1]
    pos = codes[instruction["pointer"] + 2]
    instruction["pointer"] += 3

    noun = codes[noun] if instruction["mode_1"] == 0 else noun
    verb = codes[verb] if instruction["mode_2"] == 0 else verb
    pos = codes[pos] if instruction["mode_3"] == 1 else pos

    codes[pos] = noun * verb
    return { "codes": codes, "pointer": instruction["pointer"] }

def code_3(codes, instruction):
    print('3')
    pos = codes[instruction["pointer"]]
    instruction["pointer"] += 1
    codes[pos] = instruction["input_id"]
    return { "codes": codes, "pointer": instruction["pointer"] }

def code_4(codes, instruction):
    print('4')
    pos = codes[instruction["pointer"]]
    instruction["pointer"] += 1
    print(codes[pos])
    return { "codes": codes, "pointer": instruction["pointer"] }

def code_5(codes, instruction):
    print('5')
    print(codes)
    print(instruction)
    par_1 = codes[instruction["pointer"]] # 20
    value = codes[par_1] if instruction["mode_1"] == 0 else par_1 # 98
    instruction["pointer"] += 1 # 8
    print(value)
    if value != 0:
        par_2 = codes[instruction["pointer"]] # 22
        value = codes[par_2] if instruction["mode_2"] == 1 else par_2
        instruction["pointer"] = value
    return { "codes": codes, "pointer": instruction["pointer"] }

def code_6(codes, instruction):
    print('6')
    par_1 = codes[instruction["pointer"]]
    value = codes[par_1] if instruction["mode_1"] == 0 else par_1
    instruction["pointer"] += 2
    if value == 0:
        par_2 = codes[instruction["pointer"]]
        value = codes[par_2] if instruction["mode_2"] == 1 else par_2
        instruction["pointer"] = value
    return { "codes": codes, "pointer": instruction["pointer"] }

def code_7(codes, instruction):
    print('7')
    first = codes[instruction["pointer"]]
    second = codes[instruction["pointer"] + 1]
    pos = codes[instruction["pointer"] + 2]
    instruction["pointer"] += 3

    first = codes[first] if instruction["mode_1"] == 0 else first
    second = codes[second] if instruction["mode_2"] == 0 else second
    pos = codes[second] if instruction["mode_3"] == 1 else pos
    value = 1 if first < second else 0
    codes[pos] = value
    return { "codes": codes, "pointer": instruction["pointer"] }

def code_8(codes, instruction):
    print('8')
    first = codes[instruction["pointer"]]
    second = codes[instruction["pointer"] + 1]
    pos = codes[instruction["pointer"] + 2]
    instruction["pointer"] += 3

    first = codes[first] if instruction["mode_1"] == 0 else first
    second = codes[second] if instruction["mode_2"] == 0 else second
    pos = codes[pos] if instruction["mode_3"] == 1 else pos
    value = 1 if first == second else 0
    codes[pos] = value
    return { "codes": codes, "pointer": instruction["pointer"] }

input_id = 5

process(input_id)
