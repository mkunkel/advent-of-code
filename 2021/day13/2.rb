#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def fold_horizontal(points, amount)
  points.map do |point|
    point[0] > amount ? [(amount * 2) - point[0], point[1]] : point
  end
end

def fold_vertical(points, amount)
  points.map do |point|
    point[1] > amount ? [point[0], (amount * 2) - point[1]] : point
  end
end

dots, instructions = File.read('2021/day13/input.txt').split("\n\n")

dots = dots.split("\n").map { |dot| dot.split(',').map(&:to_i) }

instructions = instructions.split("\n")

instructions.map! { |instruction| instruction.gsub('fold along ', '').split('=') }
instructions.map! { |instruction| [instruction[0], instruction[1].to_i] }

instructions.each do |instruction|
  method = instruction[0] == 'x' ? :fold_horizontal : :fold_vertical
  dots = send(method, dots, instruction[1])
end

max_x, max_y = dots.transpose.map { |x| x.max + 1 }
grid = max_y.times.map { max_x.times.map { ' ' } }
dots.each { |coord| grid[coord[1]][coord[0]] = '#' }
grid.each { |row| puts row.join }
