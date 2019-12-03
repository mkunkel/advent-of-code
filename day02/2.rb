#! /usr/bin/env ruby
input = File.read('day02/input.txt').split(',').map(&:to_i)

input[1] = 12
input[2] = 2
require 'pry'
input.each_slice(4) do |slice|
  code, noun, verb, pos = slice
  case code
  when 99
    puts input[0]
    puts "SLICE #{slice}"
    exit 0 if slice.length == 1
  when 1
    binding.pry if input[noun] + input[verb] == 19690720
    input[pos] = input[noun] + input[verb]
  when 2
    binding.pry if input[noun] + input[verb] == 19690720
    input[pos] = input[noun] * input[verb]
  end
  puts input[0]
end

puts 100 * noun + verb

numbers = (0.99).to_a

numbers.each do |noun|
  numbers.each do |verb|
    value = noun * verb
    break if value = 19690720
  end
end

puts "value: #{value}"
puts "noun: #{noun}"
puts "verb: #{verb}"
puts "total: #{100 * noun + verb}"
