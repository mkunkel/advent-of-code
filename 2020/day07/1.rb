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

def container_bags(rules, colors)
  rules.keys.select { |key| rules[key].keys.any? { |k| colors.include?(k) } }
end

input = 'shiny gold'
bags = [input]
to_test = container_bags(rules, [input])
containers = to_test.dup

until to_test.empty? do
  results = container_bags(rules, to_test)
  to_test = results.reject { |result| containers.include?(result) }
  results.each { |result| containers << result unless containers.include?(result) }
end
puts containers.count

finish = Time.new
puts "Time to run: #{(finish - start) * 1000}ms" # convert to microseconds
