#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def create_layer(rows:, cols:)
  layer = []
  row = ('.' * cols).chars
  rows.times { layer << row}
  layer
end

def surround(pocket)
  pocket.map!(&method(:surround_layer))
  cols = pocket.first.first.count
  rows = pocket.first.count
  layer = create_layer(rows: rows, cols: cols)
  pocket.unshift(layer)
  pocket << layer
  pocket
end

def surround_layer(layer)
  layer.map! do |row|
    row.unshift('.')
    row.push << '.'
  end
  cols = layer.first.count
  row = ('.' * cols).chars
  layer.unshift(row)
  layer << row
  layer
end

def enabled_neighbors(pocket:, x:, y:, z:, max: 3)
  neighbors = [x - 1, x, x + 1].product([y - 1, y, y + 1], [z - 1, z, z + 1])
  neighbors.reject! { |neighbor| neighbor == [x, y, z] }
  count = 0

  neighbors.each do |nx, ny, nz|
    count += 1 if pocket.dig(nz, ny, nx) == '#'
    break if count > max
  end
  count
end

def update(char:, pocket:, x:, y:, z:)
  neighbor_count = enabled_neighbors(pocket: pocket, x: x, y:y, z: z)
  if char == '#'
    [2, 3].include?(neighbor_count) ? '#' : '.'
  else
    neighbor_count == 3 ? '#' : '.'
  end
end

pocket = [File.read('2020/day17/input.txt').split("\n").map(&:chars)]

6.times do
  pocket = surround(pocket)
  new_pocket = pocket.map.with_index do |layer, z|
    layer.map.with_index do |row, y|
      row.map.with_index do |char, x|
        update(char: char, pocket: pocket, x: x, y: y, z: z )
      end
    end
  end
  pocket = new_pocket
end

puts pocket.join.count('#')
