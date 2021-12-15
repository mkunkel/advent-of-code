#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

template, rules = File.read('2021/day14/input.txt').split("\n\n")
rules = rules.split("\n").each_with_object({}) do |rule, hash|
  pair, char = rule.split(' -> ')
  hash[pair] = char
end

iterations = 10
iterations.times do
  polymer = ''
  (template.length - 1).times do |i|
    key = "#{template[i]}#{template[i + 1]}"
    insert = rules[key]
    polymer << "#{template[i]}#{insert}"
  end
  polymer << "#{template[-1]}"
  template = polymer.dup
end

counts = template.chars.each_with_object(Hash.new { |h, k| h[k] = 0 }) do |char, hash|
  hash[char] += 1
end

puts counts.values.max - counts.values.min
