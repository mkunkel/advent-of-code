#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

# trajectories are listed as [y, x]
TRAJECTORIES ||= {
  up:    [-1, 0],
  down:  [1, 0],
  left:  [0, -1],
  right: [0, 1]
}

HEIGHTS = ('a'..'z').to_a << 'S'

def available_directions(grid, y, x)
  return 'E' if grid[y][x] == 'E' # no need to calculate from the end
  y_max = grid.count - 1
  x_max = grid.first.count - 1

  TRAJECTORIES.select do |_key, (ty, tx)|
    new_y = y + ty
    new_x = x + tx

    # binding.pry if [y, x] == [2, 0]
    next unless new_x >= 0 && new_y >=0 && new_x <= x_max && new_y <= y_max # check if in bounds
    next if grid[new_y][new_x] == 'S'

    grid[new_y][new_x] == 'E' || HEIGHTS.index(grid[y][x]) >= HEIGHTS.index(grid[new_y][new_x]) - 1
  end.keys
end

def find_shortest_path(grid, coords, path = [], directions = [])
  result = grid[coords[0]][coords[1]].map do |direction|
    # binding.pry
    new_coords = [coords[0] + TRAJECTORIES[direction][0], coords[1] + TRAJECTORIES[direction][1]]
    next if path.include?(new_coords)
    directions << direction
    return directions if grid[new_coords[0]][new_coords[1]] == 'E'
    path << new_coords
    find_shortest_path(grid, new_coords, path, directions)
  end.reject { |p| p.nil? }.min(&:count)
end

grid = File.read('2022/day12/input.txt').split("\n").map(&:chars)

# Create a multi-dimensional array that lists available directions from each position
possibilities = grid.count.times.map do |y|
  grid.first.count.times.map do |x|
    {
      shortest: {},
      directions: available_directions(grid, y, x)
    }
  end
end

start_y = grid.index { |row| row.include?('S') }
start_x = grid[start_y].index('S')

    # binding.pry
steps = find_shortest_path(possibilities, [start_y, start_x])
binding.pry
puts steps.count
