#! /usr/bin/env ruby

input = File.read('2020/day02/input.txt').split("\n")
start = Time.new

valid = 0
input.each do |line|
  first, second, chars, password = line.match(/(\d+)-(\d+) (.+): (.+)/).captures

  positions = [
    (password[first.to_i - 1] == chars).to_s,
    (password[second.to_i - 1] == chars).to_s
  ]
  valid += 1 if positions.sort == ['false', 'true']
end
finish = Time.new


puts valid
puts "Time to run: #{(finish - start) * 1000}ms" # convert to microseconds
