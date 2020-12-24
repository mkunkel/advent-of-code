#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def next_cup(circle, pick_up, current)
  next_value = current
  min = circle.min
  max = circle.max
  while next_value == current || pick_up.include?(next_value) do
    next_value -= 1
    next_value = max if next_value < min
  end
  next_value
end

circle = File.read('2020/day23/input.txt').chomp.chars.map(&:to_i)

index = 0
count = circle.count
10.times do |it|
  current = circle[index % count]
  pick_up = []

  3.times { |i| pick_up << circle[(index + i + 1) % circle.count] }
  circle = circle - pick_up
  next_value = circle[(circle.index(current) + 1) % circle.count]
  # puts next_value
  # binding.pry unless next_value
  value = next_cup(circle, pick_up, current)
  insert_index = (circle.index(value) + 1) % count
  circle = circle.insert(insert_index, *pick_up)
  index += 1
  # binding.pry if it + 1 == 7
  until circle.index(next_value) == (index % count) do
    circle = circle.rotate
  end
puts circle.map(&:to_s).join
end

after_one = circle[(circle.index(1) + 1)..-1]
puts after_one.map(&:to_s).join
