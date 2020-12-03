#! /usr/bin/env ruby
start = Time.new

class Toboggan
  # Velocity for the y axis is technically negative, but I'm not accounting for that
  def initialize(file_path:, velocity_x:, velocity_y:)
    @rows = File.read(file_path).split
    @velocity_x = velocity_x
    @velocity_y = velocity_y
    @row_max = @rows.count - 1 # adjust for 0 index
    @col_max = @rows.first.length
    @trees_hit = 0
  end

  def run
    while current_coords[:y] <= @row_max do # adjust for 0 index
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

toboggan = Toboggan.new(file_path: '2020/day03/input.txt', velocity_x: 3, velocity_y: 1)
toboggan.run
toboggan.print_trees_hit
finish = Time.new

puts "Time to run: #{(finish - start) * 1000}ms" # convert to microseconds
