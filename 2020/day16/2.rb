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
data[:rules] = Hash.new { |h,k| h[k] = [] }
lines = File.read('2020/day16/input.txt').split("\n")
key = nil

lines.each do |line|
  if line.include?(':')
    key, value = line.split(':')
    data[:rules][key] = to_rule(value.strip) if value
  elsif line.length > 0
    value = line.split(',').map(&:to_i)
    data[key] << value
  end
end

rules = data[:rules].values.flatten
data["nearby tickets"].select! { |ticket| ticket.all? { |number| rules.include?(number) } }

key_locations = data["nearby tickets"].transpose.map do |ticket|
  data[:rules].keys.select do |key|
    ticket.all? { |number| data[:rules][key].include?(number) }
  end
end

while key_locations.map(&:count).uniq != [1] do
  singles = key_locations.select { |location| location.count == 1 }.flatten
  key_locations.map! do |location|
    location.count == 1 ? location : location.reject { |key| singles.include?(key) }
  end
end

key_locations.flatten!
data['your ticket'].flatten!
departure_keys = key_locations.select { |key| key.include?('departure') }

departure_values = departure_keys.map do |key|
  index = key_locations.index(key)
  data['your ticket'][index]
end

puts departure_values.reduce(&:*)
