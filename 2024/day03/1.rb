#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

input = File.read('2024/day03/input.txt').chomp

matches = input.scan(/mul\(\d+,\d+\)/)
products = matches.map { |match| match.scan(/\d+/).map(&:to_i).reduce(:*) }
puts products.reduce(:+)
