#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

MARKER_LENGTH = 4

chars = File.read('2022/day06/input.txt').chars

marker = nil
i = 0

until marker do
  potential_marker = chars[i, MARKER_LENGTH]
  marker = potential_marker if potential_marker.uniq == potential_marker
  i += 1 unless marker
end

puts marker.join
puts i + MARKER_LENGTH
