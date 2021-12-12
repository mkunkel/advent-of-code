#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def flash?(lines)
  lines.flatten.any? { |int| int != 'x' && int > 9 }
end

def increment_all!(lines)
  lines.map! do |row|
    row.map do |octopus|
      octopus + 1
    end
  end
end

def flash!(lines)
  return lines unless flash?(lines)
  flashers = []
  lines.each.with_index do |row, y|
    row.each.with_index do |octopus, x|
      if octopus != 'x' && octopus > 9
        flashers << [x, y]
      end
    end
  end

  flashers.each do |x, y|
    lines[y][x] = 'x'
    increment_adjacent!(lines, x, y)
  end

  flash!(lines)
end

def increment_adjacent!(lines, x, y)
  max_x = lines[0].length
  max_y = lines.length
  adjacent_coords(x, y, max_x, max_y).each do |adjx, adjy|
    lines[adjy][adjx] += 1 unless lines[adjy][adjx] == 'x'
  end
end

def start_flash(lines)
  flashers = []
  flash!(flashers, lines)
end

def adjacent_coords(x, y, max_x, max_y)
  trajectories = [-1, 0, 1].repeated_permutation(2).to_a.reject { |coords| coords == [0, 0] }
  coords = trajectories.map { |tx, ty| [x + tx, y + ty] }
  coords.reject { |x, y| x < 0 || y < 0 || x >= max_x || y >= max_y }
end

def count_flashers(lines)
  lines.flatten.count('x')
end

def replace_flashers(lines)
  lines.map! do |row|
    row.map { |octopus| octopus == 'x' ? 0 : octopus }
  end
end

lines = File.read('2021/day11/input.txt').split("\n").map { |line| line.split('').map(&:to_i) }

flashes = 0

100.times do
  increment_all!(lines)
  lines = flash!(lines)
  flashes += count_flashers(lines)
  replace_flashers(lines)
end

puts flashes
