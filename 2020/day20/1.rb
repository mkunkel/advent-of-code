#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

tiles = File.read('2020/day20/input.txt').split("\n\n")
tiles.map! do |tile|
  id, *t = tile.split("\n")
  id = id.gsub(/\D+/, '').to_i
  { id: id, tile: t }
end

edges = []
tiles.each do |tile|
  edges << tile[:tile].first
  edges << tile[:tile].last
  edges << tile[:tile].map { |t| t[0] }.join
  edges << tile[:tile].map { |t| t[-1] }.join
end

edges << edges.map(&:reverse)
edges.flatten!
uniques = edges.select { |edge| edges.count(edge) == 1 }
tiles.select! do |tile|
  tile_edges = []
  tile_edges << tile[:tile].first
  tile_edges << tile[:tile].last
  tile_edges << tile[:tile].map { |t| t[0] }.join
  tile_edges << tile[:tile].map { |t| t[-1] }.join
  uniques.select { |unique| tile_edges.include?(unique) }.count == 2
end

puts tiles.map { |tile| tile[:id] }.reduce(&:*)
