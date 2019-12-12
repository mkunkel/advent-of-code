#! /usr/bin/env ruby
require 'pry'
class Intcode
  attr_reader :completed, :output

  def initialize(file, input_ids = [])
    @file = file
    @input_ids = [*input_ids]
    @pointer = 0
    @completed = false
    @relative_base = 0
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
    # pos_mode = pos_mode.to_i == 0 ? pos_mode : 0
    # pos_mode = pos_mode.to_i == 1 ? 1 : pos_mode
    # puts num.to_s
    {
      noun_mode: noun_mode.to_i,
      verb_mode: verb_mode.to_i,
      pos_mode: pos_mode.to_i == 0 ? 1 : 0,
      opcode: opcode.join.to_i
    }
  end

  def code_1(instruction)
    noun, verb, pos = @input[@pointer, 3]

    noun = parameter_mode(instruction[:noun_mode], noun)
    verb = parameter_mode(instruction[:verb_mode], verb)
    pos = parameter_mode(instruction[:pos_mode], pos)

    @pointer += 3
    @input[pos] = noun + verb
  end

  def code_2(instruction)
    noun, verb, pos = @input[@pointer, 3]

    noun = parameter_mode(instruction[:noun_mode], noun)
    verb = parameter_mode(instruction[:verb_mode], verb)
    pos = parameter_mode(instruction[:pos_mode], pos)
    @pointer += 3

    @input[pos] = noun * verb
  end

  def code_3(instruction)
    pos = @input[@pointer]
    return wait if @input_ids.empty?
    input_id = @input_ids.shift

    # pos = parameter_mode(instruction[:verb_mode], pos)

    @pointer += 1
    @input[pos] = input_id.to_i
  end

  def code_4(instruction)
    pos = @input[@pointer]
    pos = parameter_mode(instruction[:noun_mode], pos)
    @pointer += 1
    @output = pos
    puts @output
  end

  def code_5(instruction)
    #jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to
    #the value from the second parameter. Otherwise, it does nothing.
    noun, verb = @input[@pointer, 2]

    noun = parameter_mode(instruction[:noun_mode], noun)
    verb = parameter_mode(instruction[:verb_mode], verb)
    pos = parameter_mode(instruction[:pos_mode], pos)
    @pointer += 2
    @pointer = verb unless noun == 0
  end

  def code_6(instruction)
    #jump-if-false: if the first parameter is zero, it sets the instruction pointer to
    #the value from the second parameter. Otherwise, it does nothing.
    noun, verb = @input[@pointer, 2]

    noun = parameter_mode(instruction[:noun_mode], noun)
    verb = parameter_mode(instruction[:verb_mode], verb)
    pos = parameter_mode(instruction[:pos_mode], pos)
    @pointer += 2
    @pointer = verb if noun == 0
  end

  def code_7(instruction)
    #less than: if the first parameter is less than the second parameter, it stores 1 in
    #the position given by the third parameter. Otherwise, it stores 0.
    noun, verb, pos = @input[@pointer, 3]

    noun = parameter_mode(instruction[:noun_mode], noun)
    verb = parameter_mode(instruction[:verb_mode], verb)
    pos = parameter_mode(instruction[:pos_mode], pos)
    @pointer += 3

    @input[pos] = noun < verb ? 1 : 0
  end

  def code_8(instruction)
    #equals: if the first parameter is equal to the second parameter, it stores 1 in
    #the position given by the third parameter. Otherwise, it stores 0.
    noun, verb, pos = @input[@pointer, 3]

    noun = parameter_mode(instruction[:noun_mode], noun)
    verb = parameter_mode(instruction[:verb_mode], verb)
    pos = parameter_mode(instruction[:pos_mode], pos)
    @pointer += 3

    @input[pos] = noun == verb ? 1 : 0
  end

  def code_9(instruction)
    #adjusts the relative base by the value of the first parameter
    offset = @input[@pointer]
    @pointer += 1
    # binding.pry
    offset = parameter_mode(instruction[:noun_mode], offset)
    @relative_base += offset
  end

  def parameter_mode(mode, number)
    case mode
    when 0
      @input[number] || 0
    when 1
      number
    when 2
      @input[number + @relative_base] || 0
    end
  end
end
