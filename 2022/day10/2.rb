#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

instructions = File.read('2022/day10/input.txt').split("\n")
cycle = 0
x = 1
signal_strength = 0
add_next = nil

while instructions.length > 0 do
  to_print = [1, 0, -1].include?((cycle % 40) - x) ? '#' : ' '
  print to_print
  cycle += 1
  if add_next
    x += add_next.to_i
    add_next = nil
  else
    # We only care about the number on addx
    # noop has no number, so add_next will be nil in that case
    _instruction, add_next = instructions.shift.split(' ')
  end
  puts if cycle % 40 == 0
end
puts
