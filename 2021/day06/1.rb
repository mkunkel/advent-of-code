#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

timers = File.read('2021/day06/input.txt').split(',').map(&:to_i)

days = 80

days.times do
  new_timers = 0
  timers.map! do |timer|
    new_timers += 1 if timer == 0
    timer == 0 ? 6 : timer - 1
  end
  new_timers.times { timers << 8 }
end

puts timers.count
