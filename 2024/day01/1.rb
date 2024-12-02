#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

lines = File.read('2024/day01/input.txt').split("\n")
amount = lines.count
lists = lines.map { |line| line.split(/\D+/) }.transpose
lists = lists.map { |list| list.map(&:to_i).sort }

total = 0

amount.times do |i|
  total += (lists[0][i] - lists[1][i]).abs
end

puts total
