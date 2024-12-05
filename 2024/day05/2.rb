#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def is_correct?(update, rules)
  update.each_index.map do |i|
    rule = update[i]
    before = update.take(i)
    after = i < update.length - 1 ? update[i + 1..-1] : []
    before.all? { |b| rules[b].include?(rule) } && after.all? { |a| rules[rule].include?(a) }
  end.all?
end

def incorrect_index(update, rules)
  update.each_index.map do |i|
    rule = update[i]
    before = update.take(i)
    after = i < update.length - 1 ? update[i + 1..-1] : []
    return i unless before.all? { |b| rules[b].include?(rule) } && after.all? { |a| rules[rule].include?(a) }
  end
end

def correct(update, rules)
  index = incorrect_index(update, rules)
  value = update.delete_at(index)
  insert_index = update.index { |num| !rules[num].include?(value) } || update.length
  insert_index = -1 if insert_index == index
  update.insert(insert_index, value)

  update
end


rule_list, updates = File.read('2024/day05/input.txt').split("\n\n").map { |part| part.split("\n") }

rules = Hash.new { |h,k| h[k] = [] }

rule_list.each do |rule|
  before, after = rule.split('|')
  rules[before] << after
end

updates = updates.map { |update| update.split(',') }

corrected = []

updates.each do |update|
  next if is_correct?(update, rules)

  until is_correct?(update, rules)
    update = correct(update, rules)
  end

  corrected << update
end

puts corrected.map { |update| update[update.length / 2].to_i }.reduce(:+)
