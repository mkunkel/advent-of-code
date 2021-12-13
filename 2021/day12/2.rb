#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def traverse(caves, repeat = nil, paths = [], path = ['start'])
  paths << path if path.last == 'end'
  return paths if path.last == 'end'
  # binding.pry if path == ["start", "A", "b", "A", "b", "A"]
  caves[path.last].each do |option|
    if allowed?(path, option, repeat)
      new_path = path.dup
      new_path << option
      traverse(caves, repeat, paths, new_path)
    end
  end
  paths
end

def allowed?(path, character, repeat_character)
  return true unless path.include?(character)
  return true if /[[:upper:]]/.match(character)
  return false if path.include?(character) && character != repeat_character
  path.count(repeat_character) < 2
end

connections = Hash.new { |h, k| h[k] = [] }
lines = File.read('2021/day12/input.txt').split("\n")
lines.map! { |line| line.split('-') }
lines.each do |from, to|
  connections[from] << to
  connections[to] << from
end

small_caves = connections.keys.reject { |key| /[[:upper:]]/.match(key) || key == 'start' || key == 'end' }

paths = []

small_caves.each do |cave|
  traverse(connections, cave).each { |path| paths << path }
end

paths.uniq!

puts paths.count
