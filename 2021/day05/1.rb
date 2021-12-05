#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def expand_grid(grid, vent)
  max_x = [vent[:start][0], vent[:end][0]].max
  max_y = [vent[:start][1], vent[:end][1]].max
  max_width = [grid.first.length, max_x + 1].max
  while grid.length < max_y + 1 do
    grid << []
  end

  grid.each do |row|
    while row.length < max_width do
      row << 0
    end
  end
end

def coord_list(vent)
  x = [vent[:start][0], vent[:end][0]].uniq.sort
  y = [vent[:start][1], vent[:end][1]].uniq.sort
  x = (x[0]..x[1]).to_a if x.length > 1
  y = (y[0]..y[1]).to_a if y.length > 1

  x.product(y)
end

def add_vent(grid, vent)
  coord_list(vent).each { |coord| grid[coord[1]][coord[0]] += 1 }
end

lines = File.read('2021/day05/input.txt').split("\n")
vents = lines.map do |line|
  one, two = line.split(' -> ')
  one = one.split(',').map(&:to_i)
  two = two.split(',').map(&:to_i)
  { start: one, end: two }
end

grid = [[]]

vents.each do |vent|
  if vent[:start][0] == vent[:end][0] || vent[:start][1] == vent[:end][1]
    expand_grid(grid, vent)
    add_vent(grid, vent)
  end
end

puts grid.map(&:join).map { |row| row.gsub('0', '.') }
puts
puts grid.map { |row| row.count { |int| int > 1 } }.reduce(&:+)
