#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

instructions = File.read('2022/day10/input.txt').split("\n")
cycle = 1
x = 1
signal_strength = 0
add_next = nil

while cycle < 221 do
  if add_next
    x += add_next.to_i
    add_next = nil
  else
    # We only care about the number on addx
    # noop has no number, so add_next will be nil in that case
    _instruction, add_next = instructions.shift.split(' ')
  end

  cycle += 1
  signal_strength += (x * cycle) if [20, 60, 100, 140, 180, 220].include?(cycle)
end

puts signal_strength
