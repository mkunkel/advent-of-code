#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def top_non_empty_index(array, foo, row = 0)
  return row - 1 if row >= array.length
  return row if array[row][foo] != '[-]'
  top_non_empty_index(array, foo, row + 1)
end

locations, instructions = File.read('2022/day05/input.txt').split("\n\n")
locations = locations.split("\n")
instructions = instructions.split("\n")

# Convert string into an array of crates
# This requires converting into an array of chars, slived into groups of 4, joining each group into a string
# then stripping any leading or trailing whitespace
locations.map! { |location| location.chars.each_slice(4).to_a.map { |arr| arr.join.strip } }
# Replace empty strings with a standardized empty crate position
locations.map! { |location| location.map { |loc| loc == '' ? '[-]' : loc } }

# Make sure to replace empty crate spaces!
columns = locations.pop.map(&:to_i)

# Normalize all arrays to the same length
max_length = locations.map(&:length).max
locations.map! do |location|
  until location.length == max_length do
    location << '[-]'
  end
  location
end

instructions.map! do |instruction|
  words = instruction.split(' ')
  words.each_slice(2).with_object({}) { |(key, value), hash| hash[key] = value.to_i }
end

instructions.each do |instruction|
  from = columns.index(instruction['from'])
  to = columns.index(instruction['to'])

  # Pick up all crates. Bottom crate will be in the last array position
  crates = []
  instruction['move'].to_i.times do
    # Find crate to move
    row = top_non_empty_index(locations, from)
    # Lift the crate from the stack
    crates << locations[row][from]
    locations[row][from] = '[-]'
  end

  crates.length.times do
    # Find first open location in the destination stack and set crate there
    row = top_non_empty_index(locations, to) - 1 # subtract 1 to to get the index above the top crate
    if row == -1 # Indicates there is already a crate in the top position of this stack. Add another row
      empty_row = locations[0].length.times.map { '[-]' }
      locations.unshift(empty_row)
      row = 0
    end
    locations[row][to] = crates.pop
  end
end

locations.first.length.times do |i|
  row = top_non_empty_index(locations, i)
  print locations[row][i].gsub(/[\[\]]*/, '')
end

puts
