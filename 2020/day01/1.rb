#! /usr/bin/env ruby

input = File.read('2020/day01/input.txt').split.map(&:to_i)

additions = input.map { |i| 2020 - i }

puts (input & additions).reduce(:*)
