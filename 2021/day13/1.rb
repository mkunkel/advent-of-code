#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def fold_horizontal(grid, amount)
  removed = []
  grid.each do |row|
    removed << row.pop(amount)
    row.pop
  end

  removed.each.with_index do |row, index|
    positions = (0...row.length).find_all { |i| row[i] == '#' }
    positions.each { |position| grid[index][-1 - position] = '#' }
  end
  grid
end

def fold_vertical(grid, amount)
  removed = grid.pop(amount)
  grid.pop
  removed.each.with_index do |row, index|
    positions = (0...row.length).find_all { |i| row[i] == '#' }
    positions.each { |position| grid[-1 - index][position] = '#' }
  end
  grid
end

dots, instructions = File.read('2021/day13/input.txt').split("\n\n")

dots = dots.split("\n").map { |dot| dot.split(',').map(&:to_i) }

max_x, max_y = dots.transpose.map { |x| x.max + 1 }
grid = max_y.times.map { max_x.times.map { '.' } }
dots.each { |coord| grid[coord[1]][coord[0]] = '#' }

instructions = instructions.split("\n")
instructions.map! { |instruction| instruction.gsub('fold along ', '').split('=') }
instructions.map! { |instruction| [instruction[0], instruction[1].to_i] }

instructions.each do |instruction|
  method = instruction[0] == 'x' ? :fold_horizontal : :fold_vertical
  grid = send(method, grid, instruction[1])
  puts grid.flatten.count('#')
end
