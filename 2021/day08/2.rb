#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

# numbers = %w(abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg)
lines = File.read('2021/day08/input.txt').split("\n")

lines.map! do |line|
  patterns, output = line.split('|')
  patterns = patterns.split(' ').map { |pattern| pattern.chars.sort.join }
  output = output.strip.split(' ').map { |pattern| pattern.chars.sort.join }

  six_segments = patterns.select { |pattern| pattern.length == 6 }
  five_segments = patterns.select { |pattern| pattern.length == 5 }

  one = patterns.find { |pattern| pattern.length == 2 }
  four = patterns.find { |pattern| pattern.length == 4 }
  seven = patterns.find { |pattern| pattern.length == 3 }
  eight = patterns.find { |pattern| pattern.length == 7 }

  nine = six_segments.find { |pattern| four.chars.all? { |char| pattern.chars.include?(char) } }
  six = six_segments.reject { |pattern| one.chars.all? { |char| pattern.chars.include?(char) } }[0]
  zero = six_segments.find { |pattern| pattern != nine && pattern != six }

  three = five_segments.find { |pattern| one.chars.all? { |char| pattern.chars.include?(char) }}
  five = five_segments.find { |pattern| (four.chars - one.chars).all? { |char| pattern.chars.include?(char) } }
  two = five_segments.find { |pattern| pattern != three && pattern != five }

  mappings = [zero, one, two, three, four, five, six, seven, eight, nine]

  output.map { |pattern| mappings.index(pattern) }.join.to_i
end

puts lines.sum


