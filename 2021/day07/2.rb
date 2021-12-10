#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def diff(a, b)
  (1..(a - b).abs).sum
end

positions = File.read('2021/day07/input.txt').split(',').map(&:to_i)

min = positions.min
max = positions.max

options = (min..max).to_a

consumed = options.map do |option|
  positions.map { |pos| diff(pos, option) }.sum
end

min_index = consumed.index(consumed.min)

puts positions.map { |pos| diff(pos, options[min_index]) }.sum
