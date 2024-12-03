#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

lines = File.read('2024/day02/input.txt').split("\n")
lines.map! { |line| line.split(' ').map(&:to_i) }

total = 0
lines.each do |line|
  direction = line[0] < line[1] ? 'up' : 'down'
  result = 'safe'
  line.each_cons(2) do |a, b|
    diff = direction == 'up' ? b - a : a - b
    if diff < 1 || diff > 3
      result = 'unsafe'
      break
    end
  end

  total += 1 if result == 'safe'
end

puts total
