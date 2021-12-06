#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

values = File.read('2021/day06/input.txt').split(',').map(&:to_i)

timers = (0..8).to_a.map { |i| values.count(i) }

days = 256

days.times do
  zero = timers.shift
  timers << zero
  timers[6] += zero
end

puts timers.reduce(&:+)
