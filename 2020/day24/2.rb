#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

TRAJECTORIES = {
  'e'  => { x: 2, y: 0 },
  'w'  => { x: -2, y: 0 },
  'ne' => { x: 1, y: -1 },
  'nw' => { x: -1, y: -1 },
  'se' => { x: 1, y: 1 },
  'sw' => { x: -1, y: 1 }
}

def move(position, direction)
  position[0] += TRAJECTORIES[direction][:x]
  position[1] += TRAJECTORIES[direction][:y]
  position
end

def neighbors(position)
  TRAJECTORIES.values.map { |t| [position[0] + t[:x], position[1] + t[:y]] }
end

def number_of_neighbors(position, grid)
  neighbors(position).select do |neighbor|
    grid[neighbor[1]][neighbor[0]] == 'black' if neighbor.all? { |n| n < grid.count && n >= 0 }
  end.count
end

lines = File.read('2020/day24/input.txt').split("\n")

grid_size = 300

grid = grid_size.times.map do |i|
  grid_size.times.map do |j|
    if i.even?
      j.even? ? 'white' : 'empty'
    else
      j.even? ? 'empty' : 'white'
    end
  end
end

reference = grid_size / 2

lines.each do |line|
  position = [reference, reference]
  line = line.chars
  until line.empty? do
    direction = line.shift
    direction << line.shift if direction == 'n' || direction == 's'
    position = move(position, direction)
  end

  if grid[position[1]][position[0]] == 'white'
    grid[position[1]][position[0]] = 'black'
  else
    grid[position[1]][position[0]] = 'white'
  end
end


100.times do
  new_grid = grid.map { |row| row.dup }

  grid_size.times do |y|
    grid_size.times do |x|
      next if grid[y][x] == 'empty'
      number = number_of_neighbors([x, y], grid)
      if grid[y][x] == 'black'
        new_grid[y][x] = 'white' if number == 0 || number > 2
      elsif grid[y][x] == 'white'
        new_grid[y][x] = 'black' if number == 2
      end
    end
  end
  grid = new_grid
end

puts grid.flatten.count('black')
