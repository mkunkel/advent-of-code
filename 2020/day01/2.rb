#! /usr/bin/env ruby

input = File.read('2020/day01/input.txt').split.map(&:to_i)

start = Time.new
values = input.combination(3).to_a.find { |combo| combo.reduce(:+) == 2020 }
finish = Time.new

output = values.reduce(:*)

puts output
puts "Time to run: #{(finish - start) * 1000000}µs" # convert to microseconds
