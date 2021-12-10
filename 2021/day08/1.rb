#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

# numbers = %w(abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg)
lines = File.read('2021/day08/input.txt').split("\n")

lines.map! do |line|
  patterns, output = line.split('|')
  output = output.strip.split(' ')
  output.count { |pattern| [2, 3, 4, 7].include?(pattern.length) }
end

puts lines.sum
