#! /usr/bin/env ruby
lines = File.read('day03/input.txt').split("\n").map { |line| line.split(',') }

lines.map! do |line|
  line.map do |l|
    {
      direction: l[0],
      distance: l[1..-1].to_i
    }
  end
end

directions = {
  'R' => [1, 0],
  'L' => [-1, 0],
  'U' => [0, 1],
  'D' => [0, -1]
}

paths = lines.map do |line|
  coords = [[0, 0]]
  line.each do |move|
    move[:distance].times do
      coords << [coords.last, directions[move[:direction]]].transpose.map {|x| x.reduce(:+)}
    end
  end
  coords
end

common = (paths[0] & paths[1]).reject { |coords| coords == [0, 0] }

puts common.map { |coords| paths[0].index(coords) + paths[1].index(coords) }.min
