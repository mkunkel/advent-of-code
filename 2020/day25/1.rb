#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def transform(value, subject_number = 7)
  divisor = 20201227
  value = value * subject_number
  value % divisor
end

def transform_x_times(value, x, subject_number = 7)
  x.times { value = transform(value, subject_number) }
  value
end

def find_loop_size(key)
  value = 1
  loop_number = 0
  until value == key do
    loop_number += 1
    value = transform(value)
  end
  loop_number
end

card_public_key, door_public_key  = File.read('2020/day25/input.txt').split("\n").map(&:to_i)

door_loop_size = find_loop_size(door_public_key)

puts transform_x_times(1, door_loop_size, card_public_key)
