#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def create_space(layers:, rows:, cols:)
  space = []
  layers.times { space << create_layer(rows: rows, cols: cols) }
  space
end

def create_layer(rows:, cols:)
  layer = []
  row = ('.' * cols).chars
  rows.times { layer << row}
  layer
end

def surround(pocket)
  new_pocket = pocket.map(&method(:surround_space))
  pocket = new_pocket
  cols = pocket.first.first.first.count
  rows = pocket.first.first.count
  layers = pocket.first.count
  space = create_space(layers: layers, rows: rows, cols: cols)
  pocket.unshift(space)
  pocket << space
  pocket
end

def surround_space(space)
  new_space = space.map(&method(:surround_layer))
  space = new_space
  cols = space.first.first.count
  rows = space.first.count
  layer = create_layer(rows: rows, cols: cols)
  space.unshift(layer)
  space << layer
  space
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

def enabled_neighbors(pocket:, w:, x:, y:, z:, max: 3)
  neighbors = [w - 1, w, w + 1].product([x - 1, x, x + 1], [y - 1, y, y + 1], [z - 1, z, z + 1])
  neighbors.reject! { |neighbor| neighbor == [w, x, y, z] }
  count = 0

  neighbors.each do |nw, nx, ny, nz|
    count += 1 if pocket.dig(nw, nz, ny, nx) == '#'
    break if count > max
  end
  count
end

def update(col:, pocket:, w:, x:, y:, z:)
  neighbor_count = enabled_neighbors(pocket: pocket, w: w, x: x, y:y, z: z)
  if col == '#'
    [2, 3].include?(neighbor_count) ? '#' : '.'
  else
    neighbor_count == 3 ? '#' : '.'
  end
end

pocket = [[File.read('2020/day17/input.txt').split("\n").map(&:chars)]]

6.times do
  pocket = surround(pocket)
  new_pocket = pocket.map.with_index do |space, w|
    space.map.with_index do |layer, z|
      layer.map.with_index do |row, y|
        row.map.with_index do |col, x|
          update(col: col, pocket: pocket, w: w, x: x, y: y, z: z )
        end
      end
    end
  end
  pocket = new_pocket
end

# 4d space, visualized as follows:
# pocket
#   space (w axis)
#     layer (z axis)
#       row (y axis)
#         col (x axis)

puts pocket.join.count('#')
