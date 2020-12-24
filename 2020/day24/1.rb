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

lines = File.read('2020/day24/input.txt').split("\n")

blacks = []
reference = [0, 0]

lines.each do |line|
  position = reference
  line = line.chars
  until line.empty? do
    direction = line.shift
    direction << line.shift if direction == 'n' || direction == 's'
    position = move(position, direction)
  end

  if blacks.include?(position)
    blacks.delete(position)
  else
    blacks << position
  end
end

puts blacks.count
