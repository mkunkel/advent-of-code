#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'
start = Time.new
rules = File.read('2020/day07/input.txt').split("\n")

rules = rules.each_with_object({}) do |rule, hash|
  color, details = rule.split(' bags contain ')
  next if details.include?('no other')
  hash[color] = {}
  details.split(', ').each do |detail|
    quantity, type = detail.match(/(\d+) (.*) bags?\.?/).captures
    hash[color][type] = quantity.to_i
  end
end

def container_bags(rules, color, total = 0)
  return total unless rules[color]
  rules[color].keys.each do |key|
    # puts key
    total += rules[color][key] + (rules[color][key] * container_bags(rules, key))
  end
  total
end

puts container_bags(rules, 'shiny gold')
finish = Time.new
puts "Time to run: #{(finish - start) * 1000}ms" # convert to microseconds
