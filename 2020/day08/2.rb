#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'
start = Time.new

def process(instructions, swap)
  accumulator = 0
  index = 0
  jmpnop = 0
  used = []

  while !used.include?(index) && index < instructions.length do
    used << index
    operation, argument = instructions[index].split
    operator = argument[0]
    number = argument[1..-1].to_i

    if %w(jmp nop).include?(operation)
      if jmpnop == swap
        operation = %w(jmp nop).reject { |op| op == operation }.first
      end
      jmpnop += 1
    end

    case operation
    when 'acc'
      accumulator = accumulator.send(operator, number)
      index += 1
    when 'jmp'
      index = index.send(operator, number)
    when 'nop'
      index +=1
    end
  end

  { accumulator: accumulator, index: index }
end


instructions = File.read('2020/day08/input.txt').split("\n")

swap = 0
result = {}
while result[:index] != instructions.length do
  result = process(instructions, swap)
  swap += 1
end

puts result[:accumulator]
finish = Time.new
puts "Time to run: #{(finish - start) * 1000}ms" # convert to microseconds
