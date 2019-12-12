#! /usr/bin/env ruby

require 'pry'
def process(input_ids)
  input = File.read('day07/input.txt').split(',').map(&:to_i)

  next_instruction(input, 0, input_ids)
end

def next_instruction(input, pointer, input_ids)
  instruction = to_instruction(input, pointer, input_ids)

  return input if instruction[:opcode] == 99
  result = send("code_#{instruction[:opcode]}".to_sym, input, instruction)

  next_instruction(result[:input], result[:pointer], input_ids)
end

def to_instruction(input, pointer, input_ids)
  num = input[pointer]
  pointer += 1
  pos_mode, verb_mode, noun_mode, *opcode = num.to_s.rjust(5, '0').chars

  {
    noun_mode: noun_mode.to_i,
    verb_mode: verb_mode.to_i,
    pos_mode: pos_mode.to_i,
    opcode: opcode.join.to_i,
    input_ids: input_ids,
    pointer: pointer
  }
end

def code_1(input, instruction)
  noun, verb, pos = input[instruction[:pointer], 3]
  instruction[:pointer] += 3

  noun = instruction[:noun_mode] == 0 ? input[noun] : noun
  verb = instruction[:verb_mode] == 0 ? input[verb] : verb
  pos = instruction[:pos_mode] == 1 ? input[pos] : pos
  input[pos] = noun + verb
  { input: input, pointer: instruction[:pointer] }
end

def code_2(input, instruction)
  noun, verb, pos = input[instruction[:pointer], 3]
  instruction[:pointer] += 3

  noun = instruction[:noun_mode] == 0 ? input[noun] : noun
  verb = instruction[:verb_mode] == 0 ? input[verb] : verb
  pos = instruction[:pos_mode] == 1 ? input[pos] : pos

  input[pos] = noun * verb
  { input: input, pointer: instruction[:pointer] }
end

def code_3(input, instruction)
  pos = input[instruction[:pointer]]
  instruction[:pointer] += 1
  input_id = instruction[:input_ids].shift

  while input_id.nil? do
    input_id = STDIN.gets
  end

  input[pos] = input_id.to_i
  { input: input, pointer: instruction[:pointer] }
end

def code_4(input, instruction)
  pos = input[instruction[:pointer]]
  pos = instruction[:noun_mode] == 0 ? input[pos] : pos
  instruction[:pointer] += 1
  puts pos
  { input: input, pointer: instruction[:pointer] }
end

def code_5(input, instruction)
  #jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to
  #the value from the second parameter. Otherwise, it does nothing.
  noun, verb = input[instruction[:pointer], 2]
  instruction[:pointer] += 2

  noun = instruction[:noun_mode] == 0 ? input[noun] : noun
  verb = instruction[:verb_mode] == 0 ? input[verb] : verb

  instruction[:pointer] = verb unless noun == 0
  { input: input, pointer: instruction[:pointer] }
end

def code_6(input, instruction)
  #jump-if-false: if the first parameter is zero, it sets the instruction pointer to
  #the value from the second parameter. Otherwise, it does nothing.
  noun, verb = input[instruction[:pointer], 2]
  instruction[:pointer] += 2

  noun = instruction[:noun_mode] == 0 ? input[noun] : noun
  verb = instruction[:verb_mode] == 0 ? input[verb] : verb

  instruction[:pointer] = verb if noun == 0
  { input: input, pointer: instruction[:pointer] }
end

def code_7(input, instruction)
  #less than: if the first parameter is less than the second parameter, it stores 1 in
  #the position given by the third parameter. Otherwise, it stores 0.
  noun, verb, pos = input[instruction[:pointer], 3]
  instruction[:pointer] += 3

  noun = instruction[:noun_mode] == 0 ? input[noun] : noun
  verb = instruction[:verb_mode] == 0 ? input[verb] : verb
  pos = instruction[:pos_mode] == 1 ? input[pos] : pos

  input[pos] = noun < verb ? 1 : 0
  { input: input, pointer: instruction[:pointer] }
end

def code_8(input, instruction)
  #equals: if the first parameter is equal to the second parameter, it stores 1 in
  #the position given by the third parameter. Otherwise, it stores 0.
  noun, verb, pos = input[instruction[:pointer], 3]
  instruction[:pointer] += 3

  noun = instruction[:noun_mode] == 0 ? input[noun] : noun
  verb = instruction[:verb_mode] == 0 ? input[verb] : verb
  pos = instruction[:pos_mode] == 1 ? input[pos] : pos

  input[pos] = noun == verb ? 1 : 0
  { input: input, pointer: instruction[:pointer] }
end

process(ARGV[0].split(',').map(&:to_i))
