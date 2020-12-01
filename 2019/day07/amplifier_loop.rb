#! /usr/bin/env ruby
require 'pry'
class Amplifier
  attr_reader :completed, :output

  def initialize(file, input_ids)
    @file = file
    @input_ids = [*input_ids]
    @pointer = 0
    @completed = false
    @input = File.read(@file).split(',').map(&:to_i)
  end

  def process
    next_instruction
  end

  def add_input(input)
    @input_ids << input
    @waiting = false
    next_instruction
  end

  private

  def next_instruction
    instruction = to_instruction

    return complete if instruction[:opcode] == 99
    result = send("code_#{instruction[:opcode]}".to_sym, instruction)
    next_instruction unless @waiting
  end

  def complete
    @completed = true
    @output
  end

  def wait
    @pointer -= 1
    @waiting = true
    @output
  end

  def to_instruction
    num = @input[@pointer]
    @pointer += 1
    pos_mode, verb_mode, noun_mode, *opcode = num.to_s.rjust(5, '0').chars

    {
      noun_mode: noun_mode.to_i,
      verb_mode: verb_mode.to_i,
      pos_mode: pos_mode.to_i,
      opcode: opcode.join.to_i
    }
  end

  def code_1(instruction)
    noun, verb, pos = @input[@pointer, 3]
    @pointer += 3

    noun = instruction[:noun_mode] == 0 ? @input[noun] : noun
    verb = instruction[:verb_mode] == 0 ? @input[verb] : verb
    pos = instruction[:pos_mode] == 1 ? @input[pos] : pos
    @input[pos] = noun + verb
  end

  def code_2(instruction)
    noun, verb, pos = @input[@pointer, 3]
    @pointer += 3

    noun = instruction[:noun_mode] == 0 ? @input[noun] : noun
    verb = instruction[:verb_mode] == 0 ? @input[verb] : verb
    pos = instruction[:pos_mode] == 1 ? @input[pos] : pos

    @input[pos] = noun * verb
  end

  def code_3(instruction)
    pos = @input[@pointer]
    return wait if @input_ids.empty?
    input_id = @input_ids.shift


    @pointer += 1
    @input[pos] = input_id.to_i
  end

  def code_4(instruction)
    pos = @input[@pointer]
    pos = instruction[:noun_mode] == 0 ? @input[pos] : pos
    @pointer += 1
    @output = pos
  end

  def code_5(instruction)
    #jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to
    #the value from the second parameter. Otherwise, it does nothing.
    noun, verb = @input[@pointer, 2]
    @pointer += 2

    noun = instruction[:noun_mode] == 0 ? @input[noun] : noun
    verb = instruction[:verb_mode] == 0 ? @input[verb] : verb

    @pointer = verb unless noun == 0
  end

  def code_6(instruction)
    #jump-if-false: if the first parameter is zero, it sets the instruction pointer to
    #the value from the second parameter. Otherwise, it does nothing.
    noun, verb = @input[@pointer, 2]
    @pointer += 2

    noun = instruction[:noun_mode] == 0 ? @input[noun] : noun
    verb = instruction[:verb_mode] == 0 ? @input[verb] : verb

    @pointer = verb if noun == 0
  end

  def code_7(instruction)
    #less than: if the first parameter is less than the second parameter, it stores 1 in
    #the position given by the third parameter. Otherwise, it stores 0.
    noun, verb, pos = @input[@pointer, 3]
    @pointer += 3

    noun = instruction[:noun_mode] == 0 ? @input[noun] : noun
    verb = instruction[:verb_mode] == 0 ? @input[verb] : verb
    pos = instruction[:pos_mode] == 1 ? @input[pos] : pos

    @input[pos] = noun < verb ? 1 : 0
  end

  def code_8(instruction)
    #equals: if the first parameter is equal to the second parameter, it stores 1 in
    #the position given by the third parameter. Otherwise, it stores 0.
    noun, verb, pos = @input[@pointer, 3]
    @pointer += 3

    noun = instruction[:noun_mode] == 0 ? @input[noun] : noun
    verb = instruction[:verb_mode] == 0 ? @input[verb] : verb
    pos = instruction[:pos_mode] == 1 ? @input[pos] : pos

    @input[pos] = noun == verb ? 1 : 0
  end
end
