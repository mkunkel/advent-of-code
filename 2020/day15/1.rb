#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

numbers = File.read('2020/day15/input.txt').split(',').map(&:to_i)

until numbers.length == 2020 do
  number = numbers.last
  indices = numbers.map.with_index { |num, index| num == number ? index : nil }.compact
  value = indices.count == 1 ? 0 : indices[-1] - indices[-2]
  numbers << value
end

puts numbers.last
