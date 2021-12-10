#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

positions = File.read('2021/day07/input.txt').split(',').map(&:to_i)

min = positions.min
max = positions.max

options = (min..max).to_a

consumed = options.map do |option|
  positions.map { |pos| (pos - option).abs }.sum
end

min_index = consumed.index(consumed.min)

puts positions.map { |pos| (pos - options[min_index]).abs }.sum
