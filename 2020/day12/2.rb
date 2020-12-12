#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

class Navigator
  TRAJECTORIES = {
    'N' => [0, 1],
    'S' => [0, -1],
    'E' => [1, 0],
    'W' => [-1, 0],
  }

  def initialize(instructions)
    @instructions = parse(instructions)
    @position = [0, 0]
    @waypoint = [10, 1]
  end

  def navigate
    @instructions.each do |instruction|
      case instruction[:action]
      when 'L', 'R'
        rotate(instruction[:action], instruction[:number])
      when 'F'
        move(instruction[:number])
      else
        shift(instruction[:action], instruction[:number])
      end
    end
  end

  def shift(direction, distance)
    @waypoint = [0, 1].map { |index| @waypoint[index] + (TRAJECTORIES[direction][index] * distance) }
  end

  def rotate(direction, degrees)
    turns = degrees / 90
    index = direction == 'R' ? 0 : 1
    turns.times do
      @waypoint[index] *= -1
      @waypoint = @waypoint.reverse
    end
  end

  def move(distance)
    @position = [0, 1].map { |index| @position[index] + (@waypoint[index] * distance) }
  end

  def manhattan_position
    @position[0].abs + @position[1].abs
  end

  def parse(lines)
    lines.map do |line|
      action, number = line.match(/(\w)(\d+)/).captures
      { action: action, number: number.to_i }
    end
  end
end

instructions = File.read('2020/day12/input.txt').split("\n")
nav = Navigator.new(instructions)
nav.navigate
puts nav.manhattan_position
