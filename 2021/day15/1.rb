#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def lowest_next(coord, grid)
  right = right_value(coord, grid)
  down = down_value(coord, grid)
  right < down ? right : down
end

def right_value(coord, grid)
  return 9999 if coord[1] + 1 >= grid.count || coord[0] + 1 >= grid[0].count
  grid[coord[1]][coord[0] + 1]
end

def down_value(coord, grid)
  return 9999 if coord[1] + 1 >= grid.count || coord[0] + 1 >= grid[0].count
  grid[coord[1] + 1][coord[0]]
end

# Chooses the next position based on the lowest risk of the next 2 possible positions
def pick_next(current, grid)
  exiting = [grid[-1].count - 1, grid.count - 1]
  return exiting if current == [exiting[0] - 1, exiting[1]] || current == [exiting[0], exiting[1] - 1]
  right = right_value(current, grid) + lowest_next([current[1], current[0] + 1], grid)
  down = down_value(current, grid) + lowest_next([current[1] + 1, current[0]], grid)
  right < down ? [current[0], current[1] + 1] : [current[0] + 1, current[1]]
end

def lowest_neighbor(coord, grid)
  options = [[coord[0] - 1, coord[1]], [coord[0] + 1, coord[1]], [coord[0], coord[1] - 1], [coord[0], coord[1] + 1]]
  options.reject! { |option| option[0] >= grid[0].length || option[1] >= grid.length }
  options.map { |option| grid[option[1]][option[0]] }.sort.first
end

def neighbors(coord)
  options = [[coord[0] - 1, coord[1]], [coord[0] + 1, coord[1]], [coord[0], coord[1] - 1], [coord[0], coord[1] + 1]]
  options.reject { |option| option[0] >= MAX_X || option[1] >= MAX_Y || option.any? { |opt| opt < 0 } }
end

def check_neighbors(current, grid, visited)
  current_distance = @visited[current[1]][current[0]][:distance]
  return unless new_neighbors = neighbors(current)
  new_neighbors.each do |neighbor|
    edge_distance = grid[neighbor[1]][neighbor[0]]
    neighbor_distance = @visited[neighbor[1]][neighbor[0]][:distance]
    total_distance = edge_distance + current_distance
    x = { edge_distance: edge_distance, neighbor_distance: neighbor_distance, total_distance: total_distance }
    binding.pry if neighbor = [2, 0]
    @visited[neighbor[1]][neighbor[0]][:distance] = total_distance unless neighbor_distance < total_distance
    visit(neighbor, grid, @visited) unless @visited[neighbor[1]][neighbor[0]][:@visited]
  end
end



def visit(coord, grid, visited)
  @visited[coord[1]][coord[0]][:@visited] = true
  check_neighbors(coord, grid, @visited)
end

INFINITY = 1 << 32
lines = File.read('2021/day15/input.txt').split("\n")
grid = lines.map { |line| line.split('').map(&:to_i) }

@visited = grid.count.times.map { |row| grid[0].count.times.map { { visited: false, distance: INFINITY } } }
@visited[0][0] = { visited: true, distance: 0 }
current = [0, 0]
exiting = [grid[-1].count - 1, grid.count - 1]
MAX_X = grid[0].count - 1
MAX_Y = grid.count - 1

visit(current, grid, @visited)

puts @visited.last.last[:distance]


# grid.each.with_index do |row, y|
#   row.each.with_index do |val, x|
#     @visited[y][x] = lowest_neighbor([x, y], grid) + val
#   end
# end

# binding.pry
# starting = [0, 0]
# exiting = [grid[-1].count - 1, grid.count - 1]
# current = starting.dup
# path = [] # intentionally leave starting out, since it doesn't add to risk
#
# until current == exiting do
#   current = pick_next(current, grid)
#   puts current.to_s
#   path << current
# end

# puts(path.map { |x, y| grid[y][x] }.sum)
# puts

# grid.each.with_index do |row, y|
#   puts(row.map.with_index { |val, x| path.include?([x, y]) ? val.to_s : '#' }.join)
# end

binding.pry
