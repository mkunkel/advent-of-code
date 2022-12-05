#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

class Rucksack
  # use nil to offset the array, since no items have priority 0
  PRIORITIES = [nil] + ('a'..'z').to_a + ('A'..'Z').to_a

  def initialize(items)
    @items = items
    compartmentalize
  end

  def compartmentalize
    @compartments ||= @items.chars.each_slice(@items.length / 2).to_a
  end

  def errors
    @compartments[0] & @compartments[1]
  end

  def sum
    errors.map { |error| PRIORITIES.index(error) }.uniq.sum
  end
end

rucksacks = File.read('2022/day03/input.txt').split("\n").map { |rucksack| Rucksack.new(rucksack) }

puts rucksacks.map { |rucksack| rucksack.sum }.sum
