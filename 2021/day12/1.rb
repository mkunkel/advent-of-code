#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def traverse(caves, paths = [], path = ['start'])
  paths << path if path.last == 'end'
  return paths if path.last == 'end'
  caves[path.last].each do |option|
    unless path.include?(option) && /[[:lower:]]/.match(option)
      new_path = path.dup
      new_path << option
      traverse(caves, paths, new_path)
    end
  end
  paths
end

connections = Hash.new { |h, k| h[k] = [] }
lines = File.read('2021/day12/input.txt').split("\n")
lines.map! { |line| line.split('-') }
lines.each do |from, to|
  connections[from] << to
  connections[to] << from
end

paths = traverse(connections).select { |path| path.include?('end') }

puts paths.count
