#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

class Boarding
  def initialize(layout)
    @layout = layout.map(&:chars)
    @width = @layout.first.count
    @height = @layout.count
  end

  def board
    new_layout = adjacent_layout(@layout).map(&:join)
    puts passenger_count(new_layout)
  end

  def passenger_count(new_layout)
    new_layout.join.count('#')
  end

  def adjacent_layout(current_layout)
    new_layout = update_layout(current_layout)
    new_layout == current_layout ? new_layout : adjacent_layout(new_layout)
  end

  def update_layout(current_layout)
    current_layout.map.with_index do |row, y|
      row.map.with_index do |location, x|
        if location == '.'
          '.'
        elsif location == 'L'
          adjacent_count(current_layout, x, y) == 0 ? '#' : 'L'
        elsif location == '#'
          adjacent_count(current_layout, x, y) >= 5 ? 'L' : '#'
        end
      end
    end
  end

  def adjacent_count(current_layout, x, y)
    trajectories = [1, 0, -1].product([1, 0, -1]).reject { |trajectory| trajectory == [0, 0] }
    trajectories.map do |tx, ty|
      value = nil
      next_x = x
      next_y = y
      until value do
        next_x = next_x + tx
        next_y = next_y + ty

        if out_of_bounds?(next_x, next_y) || current_layout[next_y][next_x] == 'L'
          value = 0
        else
          value = current_layout[next_y][next_x] == '#' ? 1 : nil
        end
      end
      value
    end.reduce(&:+)
  end

  def out_of_bounds?(x, y)
    x < 0 || y < 0 || x >= @width || y >= @height
  end
end


layout = File.read('2020/day11/input.txt').split("\n")
Boarding.new(layout).board
