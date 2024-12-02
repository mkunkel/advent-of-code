#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

lines = File.read('2023/day01/input.txt').split("\n")

NUMBER_STRS = %w(zero one two three four five six seven eight nine)

def parse_line(line)
  shortest_length = NUMBER_STRS.min { |a, b| a.length <=> b.length }.length
  numbers = []
  line.length.times do |i|
    if %w(0 1 2 3 4 5 6 7 8 9).include?(line[i])
      numbers << line[i].to_i
    else
      NUMBER_STRS.each.with_index do |str, x|
        if line.slice(i, str.length) == str
          numbers << x
          break
        end
      end
    end
  end

  numbers
end


lines.map! do |line|
  numbers = parse_line(line)
  number_string = numbers.length == 1 ? numbers.first : (numbers.first.to_s + numbers.last.to_s).to_i
  number_string.to_i
end

puts lines.sum
