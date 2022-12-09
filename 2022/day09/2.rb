#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def move_amount(number)
  return number if number == 0
  number > 0 ? 1 : -1
end

def next_move(head, tail)
  x = head[0] - tail[0]
  y = head[1] - tail[1]

  # If x and y are within 1 away, head and tail are touching
  # return nil, since the tail does not need to move
  return if x.abs <= 1 && y.abs <= 1

  tail[0] += move_amount(x)
  tail[1] += move_amount(y)
  tail
end

moves = File.read('2022/day09/input.txt').split("\n")

knots = []
10.times { knots << [[0, 0]] }


moves.each do |move|
  direction, amount = move.split(' ')
  amount.to_i.times do
    # Move "head" knot first
    knots.first.first[0] += TRAJECTORIES[direction][0]
    knots.first.first[1] += TRAJECTORIES[direction][1]

    # Now "tail" knots can follow
    knots.each_cons(2) do |head, tail|
      new_position = next_move(head.last, tail.last.dup)
      tail << new_position if new_position
    end
  end
end

puts knots.last.uniq.count
