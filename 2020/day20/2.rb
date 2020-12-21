#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def tile_matches?(tile, above, left, alignment)
  mating_sides = tile[:sides].keys - tile[:uniques].keys
  tile = orient_to_alignment(tile, alignment)
  available_sides = tile[:sides].keys - tile[:uniques].keys
  available_sides.map! { |side| tile[:sides][side] }
  return false unless [above, left].all? { |side| available_sides.include?(side) || available_sides.include?(side.reverse) }
  if alignment.count ==

  above_match = above.nil? ||
  left_match = left.nil? ||

  above_match && left_match
end

def find_from_tiles(tiles, grid, x, y, alignment)
  tiles.find do |tile|
    above = grid.dig(y - 1, x, :sides, :bottom)
    left = grid.dig(y, x - 1, :sides, :right)
    tile_matches?(tile, above, left, alignment)
  end
end

def orient_to_alignment(tile, alignment)
  until tile[:uniques].keys.sort == alignment.sort
    tile = rotate(tile)
  end
  tile
end

def rotate(tile)
  tile[:tile] = tile[:tile].map(&:reverse).map(&:chars).transpose.map(&:join)
  new_orientation_map = { top: :left, left: :bottom, bottom: :right, right: :top }
  tile[:sides] = tile_sides(tile[:tile])
  tile[:uniques] = tile[:uniques].keys.each_with_object({}) do |key, hash|
    hash[new_orientation_map[key]] = tile[:sides][new_orientation_map[key]]
  end
  tile
end

def mirror_x(tile)
  tile.map { |row| row.reverse }
end

def mirror_y(tile)
  tile.reverse
end

def tile_sides(tile)
  {
    top: tile.first,
    bottom: tile.last,
    left: tile.map { |t| t[0] }.join,
    right: tile.map { |t| t[-1] }.join
  }
end

tiles = File.read('2020/day20/input.txt').split("\n\n")
tiles.map! do |tile|
  id, *t = tile.split("\n")
  id = id.gsub(/\D+/, '').to_i
  # t = t.map { |row| row.chars }
  tile = { id: id, tile: t, sides: {} }
  tile[:sides] = tile_sides(tile[:tile])
  tile
end

edges = []
tiles.each { |tile| edges << tile[:sides].values }

edges.flatten!
edges << edges.map(&:reverse)
edges.flatten!
uniques = edges.select { |edge| edges.count(edge) == 1 }

tiles.each do |tile|
  tile[:uniques] = {}
  tile[:sides].each_pair { |k, v| tile[:uniques][k] = v if uniques.include?(v) }
end

corners = tiles.select do |tile|
  uniques.select { |unique| tile[:sides].values.include?(unique) }.count == 2
end

sides = tiles.select do |tile|
  uniques.select { |unique| tile[:sides].values.include?(unique) }.count == 1
end

inners = tiles - corners - sides
row_count = (sides.count / 4) + 2

grid = row_count.times.map { row_count.times.map { nil } }

row_count.times do |y|
  row_count.times do |x|
    alignment = []
    alignment << x == 0 ? :left : :right if x == 0 || x == row_count - 1
    alignment << y == 0 ? :top : :bottom if y == 0 || y == row_count - 1
    if alignment.count == 2
      tile = find_from_tiles(corners, grid, x, y, alignment)
      grid[y][x] = tile
      corners.delete(tile)
    elsif alignment.count == 1
      tile = find_from_tiles(sides, grid, x, y, alignment)
      grid[y][x] = tile
      sides.delete(tile)
    else
      tile = find_from_tiles(inners, grid, x, y, alignment)
      grid[y][x] = tile
      inners.delete(tile)
    end
  end
end
