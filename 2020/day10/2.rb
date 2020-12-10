#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def ascend(adapters, key, value = 0)
  unless adapters.keys.include?(key)
    value += 1
  else
    adapters[key].each do |next_key|
      value = ascend(adapters, next_key.to_s, value)
    end
  end
  value
end

adapters = File.read('2020/day10/input.txt').split("\n").map(&:to_i).sort
used_adapters = [0]
jolts = 0
built_in_adapter = 3
possible_adapters = {}

adapters.unshift(0)
adapters << adapters.last + 3

adapters.each do |adapter|
  possible_adapters[adapter.to_s] = adapters.select { |a| a >= adapter + 1 && a <= adapter + 3 }
end

slices = []
current_slice = {}

possible_adapters.each_pair do |key, value|
  current_slice[key] = value
  diffs = value.map { |val| val - key.to_i }
  if diffs == [3]
    slices << current_slice
    current_slice = { key => value}
  end
end

combos = slices.map do |slice|
  ascend(slice, slice.keys.first)
end

puts combos.reduce(&:*)
