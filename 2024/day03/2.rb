#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def strip_donts(input, acc = [])
  head, tail = input.split(/don't\(\)/, 2)
  acc << head
  return acc if tail.nil?
  head, tail = tail.split(/do\(\)/, 2) unless tail.nil?

  strip_donts(tail, acc)
end

input = File.read('2024/day03/input.txt').chomp
parts = strip_donts(input).join

matches = parts.scan(/mul\(\d+,\d+\)/)
products = matches.map { |match| match.scan(/\d+/).map(&:to_i).reduce(:*) }
puts products.reduce(:+)
