#! /usr/bin/env ruby

input = File.read('2020/day01/input.txt').split.map(&:to_i)
start = Time.new
additions = input.map { |i| 2020 - i }
finish = Time.new


puts (input & additions).reduce(:*)
puts "Time to run: #{(finish - start) * 1000000}µs" # convert to microseconds
