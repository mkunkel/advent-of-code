#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

numbers = File.read('2020/day09/input.txt').split("\n").map(&:to_i)

target = 1398413738

numbers.each.with_index do |number, index|
  next if number == target
  range = [number]
  i = 1
  while range.reduce(&:+) < target do
    range << numbers[index + i]
    i +=1
  end
  if range.reduce(&:+) == target
    puts range.min + range.max
    break
  else
    i = 1
  end
end
