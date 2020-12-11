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
          adjacent_count(current_layout, x, y) >= 4 ? 'L' : '#'
        end
      end
    end
  end

  def adjacent_count(current_layout, x, y)
    adjacent_coords(x, y).map do |ac_x, ac_y|
      current_layout[ac_y][ac_x] == '#' ? 1 : 0
    end.reduce(&:+)
  end

  def adjacent_coords(x, y)
    x_possibilities = [x - 1, x, x + 1]
    y_possibilities = [y - 1, y, y + 1]
    possibilities = x_possibilities.product(y_possibilities)
    possibilities.reject { |px, py| [x, y] == [px, py] || out_of_bounds?(px, py) }
  end

  def out_of_bounds?(x, y)
    x < 0 || y < 0 || x >= @width || y >= @height
  end
end


layout = File.read('2020/day11/input.txt').split("\n")
Boarding.new(layout).board
