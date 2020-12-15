#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

numbers = File.read('2020/day15/input.txt').chomp.split(',')

indices = Hash.new { |h,k| h[k] = [] }
numbers.each_with_index do |number, index|
  indices[number.to_i] << index
  indices[:last] = number
end

index = numbers.count
until index == 30000000 do
  number = indices[:last].to_i
  count = indices[number].count
  value = count == 1 ? 0 : indices[number][-1] - indices[number][-2]
  indices[value] << index
  indices[value] = indices[value].last(2)
  indices[:last] = value
  index += 1
end

puts indices[:last]
