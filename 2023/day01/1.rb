#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

lines = File.read('2023/day01/input.txt').split("\n")
lines.map! do |line|
  numbers = line.scan(/\d/)
  (numbers.first + numbers.last).to_i
end

puts lines.sum
