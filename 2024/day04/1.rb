#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

grid = File.read('2024/day04/input.txt').chomp.split("\n").map(&:chars)
TRAJECTORIES = [-1, 0, 1].repeated_permutation(2).to_a.reject { |coords| coords == [0, 0] }
ROW_COUNT = grid.count
COLS_COUNT = grid[0].count

def out_of_bounds?(x, y)
  x < 0 || y < 0 || x >= COLS_COUNT || y >= ROW_COUNT
end

def new_coords(x, y, tx, ty)
  [x + tx, y + ty]
end

def traverse(grid, coords, trajectory, remaining_letters)
  count = 0
  x, y = coords
  tx, ty = trajectory
  new_x, new_y = new_coords(x, y, tx, ty)
  return 0 if out_of_bounds?(new_x, new_y)
  letter = remaining_letters.shift

  if grid[new_y][new_x] == letter && remaining_letters.length == 0
    return 1
  elsif grid[new_y][new_x] == letter
    count = traverse(grid, [new_x, new_y], trajectory, remaining_letters.dup)
  end

  count
end

count = 0

grid.each.with_index do |row, y|
  row.each.with_index do |cell, x|
    next unless cell == 'X'
    TRAJECTORIES.each do |tx, ty|
      new_x, new_y = new_coords(x, y, tx, ty)
      next if out_of_bounds?(new_x, new_y)

      count += traverse(grid, [x, y], [tx, ty], 'MAS'.chars)
    end
  end
end

puts count
