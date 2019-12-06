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
        "pos_mode": int(extended[0]),
        "verb_mode": int(extended[1]),
        "noun_mode": int(extended[2]),
        "opcode": int(extended[3:5]),
        "pointer": pointer,
        "input_id": input_id
    }

def code_1(codes, instruction):
    noun = codes[instruction["pointer"]]
    verb = codes[instruction["pointer"] + 1]
    pos = codes[instruction["pointer"] + 2]
    instruction["pointer"] += 3

    noun = codes[noun] if instruction["noun_mode"] == 0 else noun
    verb = codes[verb] if instruction["verb_mode"] == 0 else verb
    pos = codes[pos] if instruction["pos_mode"] == 1 else pos

    codes[pos] = noun + verb
    return { "codes": codes, "pointer": instruction["pointer"] }

def code_2(codes, instruction):
    noun = codes[instruction["pointer"]]
    verb = codes[instruction["pointer"] + 1]
    pos = codes[instruction["pointer"] + 2]
    instruction["pointer"] += 3

    noun = codes[noun] if instruction["noun_mode"] == 0 else noun
    verb = codes[verb] if instruction["verb_mode"] == 0 else verb
    pos = codes[pos] if instruction["pos_mode"] == 1 else pos

    codes[pos] = noun * verb
    return { "codes": codes, "pointer": instruction["pointer"] }

def code_3(codes, instruction):
    pos = codes[instruction["pointer"]]
    instruction["pointer"] += 1
    codes[pos] = instruction["input_id"]
    return { "codes": codes, "pointer": instruction["pointer"] }

def code_4(codes, instruction):
    pos = codes[instruction["pointer"]]
    instruction["pointer"] += 1
    print(codes[pos])
    return { "codes": codes, "pointer": instruction["pointer"] }


input_id = 1


process(input_id)
