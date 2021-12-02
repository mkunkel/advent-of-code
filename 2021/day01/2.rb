#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

lines = File.read('2021/day01/input.txt').split("\n").map(&:to_i)

depths = lines.map.with_index do |line, i|
  i < 2 ? 0 : line + lines[i - 1] + lines[i - 2]
end

changes = depths.map.with_index do |depth, i|
  i > 0 && depth.to_i > depths[i - 1].to_i ? 'increased' : 'decreased'
end

puts changes[3..-1].count { |change| change == 'increased' }
