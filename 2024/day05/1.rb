#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

rule_list, updates = File.read('2024/day05/input.txt').split("\n\n").map { |part| part.split("\n") }

rules = Hash.new { |h,k| h[k] = [] }

rule_list.each do |rule|
  before, after = rule.split('|')
  rules[before] << after
end

updates = updates.map { |update| update.split(',') }

correct = updates.select do |update|
  length = update.length
  valid = update.each_index.map do |i|
    rule = update[i]
    before = update.take(i)
    after = i < update.length - 1 ? update[i + 1..-1] : []

    before.all? { |b| rules[b].include?(rule) } && after.all? { |a| rules[rule].include?(a) }
  end
  valid.all?
end

puts correct.map { |update| update[update.length / 2].to_i }.reduce(:+)
