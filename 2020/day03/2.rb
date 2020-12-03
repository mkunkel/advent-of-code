#! /usr/bin/env ruby
start = Time.new

class Toboggan
  # Velocity for the y axis is technically negative, but I'm not accounting for that
  attr_reader :trees_hit
  def initialize(rows:, velocity_x:, velocity_y:)
    @rows = rows
    @velocity_x = velocity_x
    @velocity_y = velocity_y
    @row_max = @rows.count - 1 # adjust for 0 index
    @col_max = @rows.first.length
    @trees_hit = 0
  end

  def run
    while current_coords[:y] <= @row_max do
      @trees_hit += 1 if @rows[current_coords[:y]][current_coords[:x]] =='#'
      increment_coords
    end
  end

  def current_coords
    @current_coords ||= { x: @velocity_x, y: @velocity_y }
  end

  def increment_coords
    current_coords[:x] = (current_coords[:x] + @velocity_x) % @col_max
    current_coords[:y] += @velocity_y
  end

  def print_trees_hit
    puts @trees_hit
  end
end

rows = File.read('2020/day03/input.txt').split

velocities = [
  { x: 1, y: 1 },
  { x: 3, y: 1 },
  { x: 5, y: 1 },
  { x: 7, y: 1 },
  { x: 1, y: 2 }
]

total = velocities.map do |velocity|
  toboggan = Toboggan.new(rows: rows, velocity_x: velocity[:x], velocity_y: velocity[:y])
  toboggan.run
  toboggan.trees_hit
end.reduce(&:*)

puts total
finish = Time.new

puts "Time to run: #{(finish - start) * 1000}ms" # convert to microseconds
