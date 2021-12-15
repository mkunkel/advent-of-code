#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

ITERATIONS = 40

template, rules = File.read('2021/day14/input.txt').split("\n\n")

RULES = rules.split("\n").each_with_object({}) do |rule, hash|
  pair, char = rule.split(' -> ')
  hash[pair] = [
    [pair.chars.first, char].join,
    [char, pair.chars.last].join
  ]
end

counts = template.chars.each_cons(2).each_with_object(Hash.new(0)) do |pair, hash|
  hash[pair.join] += 1
end

ITERATIONS.times do |i|
  counts = counts.each_with_object(Hash.new(0)) do |(k,v), hash|
    RULES[k].each { |key| hash[key] += v }
  end
end
letters = counts.each_with_object(Hash.new(0)) do |(k,v), hash|
  hash[k.chars[0]] += v
end

letters[template.chars.last] += 1

 puts letters.values.max - letters.values.min
