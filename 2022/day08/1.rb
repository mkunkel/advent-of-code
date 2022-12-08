#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def at_edge?(array, row, col)
  return true if row == 0 || col == 0
  row == array.count - 1 || col == array.first.count - 1
end

def in_bounds?(array, row, col)
  return false if row < 0 || col < 0
  row < array.count && col < array.first.count
end

def visible?(array, row, col)
  return true if at_edge?(array, row, col)
  tree = array[row][col]
  trajectories = [[-1, 0], [1, 0], [0, -1], [0, 1]]

  trajectories.any? do |y, x|
    visible = true
    r = row
    c = col
    while in_bounds?(array, r, c) do
      r += y
      c += x
      if !in_bounds?(array, r, c)
        break
      elsif array[r][c] >= tree
        visible = false
        break
      end
    end
    visible
  end
end

trees = File.read('2022/day08/input.txt').split("\n").map { |line| line.chars.map(&:to_i) }

visible = 0

trees.each.with_index do |row, row_i|
  row.each.with_index do |tree, col_i|
    visible += 1 if visible?(trees, row_i, col_i)
  end
end

puts visible
