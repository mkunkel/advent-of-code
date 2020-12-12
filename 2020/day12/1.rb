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
    @facing = 'E'
    @position = [0, 0]
  end

  def navigate
    @instructions.each do |instruction|
      case instruction[:action]
      when 'L', 'R'
        turn(instruction[:action], instruction[:number])
      when 'F'
        move(@facing, instruction[:number])
      else
        move(instruction[:action], instruction[:number])
      end
    end
  end

  def turn(direction, degrees)
    turns = degrees / 90
    modifier = direction == 'R' ? 1 : -1
    directions = %w(N E S W)
    current_index = directions.index(@facing)
    new_index = (current_index + (modifier * turns)) % 4
    @facing = directions[new_index]
  end

  def move(direction, distance)
    trajectory = TRAJECTORIES[direction].map { |t| t * distance }
    @position = [0, 1].map { |index| @position[index] + trajectory[index] }
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
