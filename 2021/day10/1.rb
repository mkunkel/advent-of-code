#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def remove_pairs(line)
  pairs = ['()', '[]', '{}', '<>' ]
  clone = line.dup
  pairs.each { |pair| clone.gsub!(pair, '') }
  clone
end

lines = File.read('2021/day10/input.txt').split("\n")
pairings = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
scores = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25137 }

errors = []

lines.each do |line|
  while line != remove_pairs(line) do
    line = remove_pairs(line)
  end

  error_index = pairings.values.map { |close| line.index(close) }.compact.sort.first
  errors << line[error_index] if error_index
end

puts(errors.map { |error| scores[error] }.sum)
