#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

grid = File.read('2024/day04/input.txt').chomp.split("\n").map(&:chars)

WORD = 'MAS'
examples = [WORD.chars, WORD.reverse.chars].repeated_permutation(2).map do |word1, word2|
  [
    [word1[0], '*', word2[0]],
    ['*', word1[1], '*'],
    [word2[2], '*', word1[2]]
  ]
end

count = 0

grid.each_cons(3).with_index do |rows, y|
  x = 0
  while x < rows[0].count - 2
    set = rows.map { |row| row.slice(x, 3) }
    [[0, 1], [1, 0], [1, 2], [2, 1]].each { |(y, x)| set[y][x] = '*' }

    count += 1 if examples.include?(set)
    x += 1
  end
end

puts count
