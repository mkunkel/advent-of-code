#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def in_order?(pair)
  left = Array(pair[0])
  right = Array(pair[1])
  result = nil

  left.each.with_index do |left_value, i|
    result = if [left_value, right[i]].any? { |signal| signal.nil? }
      left_value.nil?
    elsif left_value.is_a?(Integer) && right[i].is_a?(Integer)
      compare_values(left_value, right[i])
    elsif [left_value, right[i]].any? { |signal| signal.is_a?(Array) }
      in_order?([left_value, right[i]])
    end
    return result unless result.nil?
  end
  true
end

def compare_values(left, right)
  return nil if left == right
  left < right
end

pairs = File.read('2022/day13/input.txt').split("\n\n").map do |pair|
  pair.split("\n").map(&method(:eval))
end

total = pairs.map.with_index do |pair, i|
  in_order?(pair) ? i + 1 : 0
end.sum

puts total
