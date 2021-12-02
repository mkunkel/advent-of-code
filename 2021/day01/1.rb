#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

lines = File.read('2021/day01/input.txt').split("\n")

changes = lines.map.with_index do |line, i|
  line.to_i > lines[i - 1].to_i ? 'increased' : 'decreased'
end[1..-1]

puts changes.count { |change| change == 'increased' }
