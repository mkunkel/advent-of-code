#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'
start = Time.new
instructions = File.read('2020/day08/input.txt').split("\n")

accumulator = 0
index = 0
used = []

while !used.include?(index) do
  used << index
  operation, argument = instructions[index].split
  operator = argument[0]
  number = argument[1..-1].to_i

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

puts accumulator
finish = Time.new
puts "Time to run: #{(finish - start) * 1000}ms" # convert to microseconds
