#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def remove_pairs(line)
  pairs = ['()', '[]', '{}', '<>' ]
  clone = line.dup
  pairs.each { |pair| clone.gsub!(pair, '') }
  clone
end

def score(str)
  scores = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }
  current = 0
  str.each do |char|
    current *= 5
    current += scores[char]
  end
  current
end

lines = File.read('2021/day10/input.txt').split("\n")
pairings = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }

incomplete = []

lines.each do |line|
  while line != remove_pairs(line) do
    line = remove_pairs(line)
  end

  error_index = pairings.values.map { |close| line.index(close) }.compact.sort.first
  incomplete << line unless error_index
end

fixes = incomplete.map { |str| str.reverse.chars.map { |char| pairings[char] } }

scores = fixes.map { |fix| score(fix) }.sort

puts scores[scores.count / 2]
