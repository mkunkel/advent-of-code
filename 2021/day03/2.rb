#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

lines = File.read('2021/day03/input.txt').split("\n").map { |line| line.chars }

# I'm sure there is a method available to do this
# but I wanted to write it anyway
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

def oxygen(lines, position = 0)
  values = lines.dup
  current = values.map { |value| value[position].to_i }
  ones = current.count(1)
  zeroes = current.count(0)
  most_common = zeroes > ones ? '0' : '1'
  values.select! { |value| value[position] == most_common }

  values.count > 1 ? oxygen(values, position + 1) : values.first
end

def co_two(lines, position = 0)
  values = lines.dup
  current = values.map { |value| value[position].to_i }
  ones = current.count(1)
  zeroes = current.count(0)
  least_common = ones < zeroes ? '1' : '0'
  values.select! { |value| value[position] == least_common }

  values.count > 1 ? co_two(values, position + 1) : values.first
end

puts to_decimal(oxygen(lines)) * to_decimal(co_two(lines))
