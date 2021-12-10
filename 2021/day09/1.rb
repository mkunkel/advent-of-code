#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def adjacent(x, y)
  [[x, y + 1], [x, y - 1], [x + 1, y], [x - 1, y]]
end

def low?(x, y)
  rows = lines.count
  cols = lines[0].count
  coords = adjacent(x, y).reject { |x, y| y >= rows || x >= cols || x < 0 || y < 0 }
  coords.map { |coord_x, coord_y| lines[coord_y][coord_x] }.all? { |value| value > lines[y][x] }
end

def lines
  return @lines if @lines
  @lines = File.read('2021/day09/input.txt').split("\n")
  @lines.map! { |line| line.chars.map(&:to_i) }
end

lows = []

lines.each.with_index do |line, y|
  line.each.with_index { |height, x| lows << height if low?(x, y) }
end

puts lows.sum + lows.count
