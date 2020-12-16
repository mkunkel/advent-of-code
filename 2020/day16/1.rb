#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def to_rule(string)
  values = []
  rules = string.split(' or ')
  rules.each do |rule|
    min, max = rule.split('-')
    values << (min.to_i..max.to_i).to_a
  end
  values.flatten
end

data = Hash.new { |h,k| h[k] = [] }
lines = File.read('2020/day16/input.txt').split("\n")
key = nil

lines.each do |line|
  if line.include?(':')
    key, value = line.split(':')
    data[:rules] << to_rule(value.strip) if value
  elsif line.length > 0
    value = line.split(',').map(&:to_i)
    data[key] << value
  end
end

invalid_numbers = []
rules = data[:rules].flatten
data["nearby tickets"].each do |ticket|
  ticket.each do |number|
    invalid_numbers << number unless rules.include?(number)
  end
end

puts invalid_numbers.reduce(&:+)
