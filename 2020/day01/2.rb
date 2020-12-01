#! /usr/bin/env ruby

input = File.read('2020/day01/input.txt').split.map(&:to_i)

values = input.combination(3).to_a.find { |combo| combo.reduce(:+) == 2020 }

puts values.reduce(:*)
