#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def in_bounds?(array, row, col)
  return false if row < 0 || col < 0
  row < array.count && col < array.first.count
end

def score(array, row, col)
  tree = array[row][col]
  trajectories = [[-1, 0], [1, 0], [0, -1], [0, 1]]

  trajectories.map do |y, x|
    visible = 0
    r = row
    c = col
    while in_bounds?(array, r, c) do
      r += y
      c += x
      if !in_bounds?(array, r, c)
        break
      else
        if array[r][c] >= tree
          visible += 1
          break
        else
          visible += 1
        end
      end
    end
    visible
  end.reduce(&:*)
end

trees = File.read('2022/day08/input.txt').split("\n").map { |line| line.chars.map(&:to_i) }



scores = trees.map.with_index do |row, row_i|
  row.map.with_index do |tree, col_i|
    score(trees, row_i, col_i)
  end
end

puts scores.map { |score| score.max }.max
