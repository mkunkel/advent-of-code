#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def valid_message?(message, rules)
  rule_matches?(rules['0'], message, rules) == ''
end

def rule_matches?(rule, message, rules)
  return false if message == false
  if rule.start_with?('"')
    letter = rule.gsub('"', '')
    message.start_with?(letter) ? message[1..-1] : false
  elsif rule.include?('|')
    options = rule.split(' | ')
    rule_matches?(options[0], message, rules) || rule_matches?(options[1], message, rules)
  elsif rule.include?(' ')
    options = rule.split(' ')
    index = 0
    tmp_message = message

    while index < options.count && tmp_message != false do
      tmp_message = rule_matches?(rules[options[index]], tmp_message, rules)
      break if tmp_message == false
      index += 1
    end
    tmp_message
  else
    rule_matches?(rules[rule], message, rules)
  end
end

lines = File.read('2020/day19/input.txt').split("\n")
rules = {}
messages = []
separator_found = false

lines.each do |line|
  if separator_found
    messages << line
  elsif line == ''
    separator_found = true
  else
    number, rule = line.split(': ')
    rules[number] = rule
  end
end

validity = messages.map do |message|
  valid_message?(message, rules)
end

puts validity.count(true)
