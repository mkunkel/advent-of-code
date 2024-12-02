#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

lines = File.read('2024/day01/input.txt').split("\n")
lists = lines.map { |line| line.split(/\D+/) }.transpose
lists = lists.map { |list| list.map(&:to_i) }
total = 0

lists.first.each_with_index do |num, i|
  total += num * lists.last.count(num)
end

puts total
