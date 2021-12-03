#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

lines = File.read('2021/day02/input.txt').split("\n")

horizontal = 0
vertical = 0

lines.each do |line|
  direction, amount = line.split(' ')
  case direction
  when 'forward'
    horizontal += amount.to_i
  when 'down'
    vertical += amount.to_i
  when 'up'
    vertical -= amount.to_i
  end
end

puts horizontal * vertical
