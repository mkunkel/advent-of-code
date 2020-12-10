#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

numbers = File.read('2020/day09/input.txt').split("\n").map(&:to_i)
start = 0
preamble_length = 25

while start + preamble_length < numbers.length do
  preamble = numbers.slice(start, preamble_length)
  target = numbers[start + preamble_length]
  break if preamble.none? { |number| target - number != number && preamble.include?(target - number) }
  start += 1
end

puts target
