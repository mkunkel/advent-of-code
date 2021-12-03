#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

lines = File.read('2021/day03/input.txt').split("\n").map { |line| line.chars }

# I'm sure there is a method available to do this
# but I wanted to write it anyway
def common(lines)
  lines.transpose.map { |line| line.max_by { |char| line.count(char) } }
end

def to_decimal(values, true_bit = '1')
  position = 1
  total = 0
  while values.count > 0 do
    value = values.pop
    total += position if value == true_bit
    position *= 2
  end
  total
end


puts to_decimal(common(lines)) * to_decimal(common(lines), '0')
