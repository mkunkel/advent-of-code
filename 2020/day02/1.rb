#! /usr/bin/env ruby

input = File.read('2020/day02/input.txt').split("\n")
start = Time.new

valid = 0
input.each do |line|
  min, max, chars, password = line.match(/(\d+)-(\d+) (.+): (.+)/).captures
  count = password.scan(/(#{chars})/).count
  valid +=1 if count >= min.to_i && count <= max.to_i
end
finish = Time.new


puts valid
puts "Time to run: #{(finish - start) * 1000}ms" # convert to microseconds
