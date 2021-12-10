#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def adjacent(x, y)
  [[x, y + 1], [x, y - 1], [x + 1, y], [x - 1, y]].reject { |coord_x, coord_y| coord_y >= rows || coord_x >= cols || coord_x < 0 || coord_y < 0 }
end

def low?(x, y)
  coords = adjacent(x, y)
  coords.map { |coord_x, coord_y| lines[coord_y][coord_x] }.all? { |value| value > lines[y][x] }
end

def explore_basin(coord, coords = nil, border = [])
  coords = [coord] unless coords
  to_test = adjacent(coord[0], coord[1]).reject { |adj| coords.include?(adj) || border.include?(adj) }

  unless to_test.empty?
    to_test.each do |c|
      if lines[c[1]][c[0]] == 9
        border << c
      else
        coords << c
        explore_basin(c, coords, border)
      end
    end
  end
  [coords.uniq, border.uniq]
end

def rows
  @rows ||= lines.count
end

def cols
  @cols ||= lines[0].count
end

def lines
  return @lines if @lines
  @lines = File.read('2021/day09/input.txt').split("\n")
  @lines.map! { |line| line.chars.map(&:to_i) }
end

lows = []

lines.each.with_index do |line, y|
  line.each.with_index { |height, x| lows << [x, y] if low?(x, y) }
end

basins = []

lows.each do |low|
  basins << explore_basin(low)[0]
end

output = basins.map do |basin|
  basin.count
end.sort.pop(3).reduce(&:*)

puts output
