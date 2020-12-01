#! /usr/bin/env ruby

input = File.read('day01/input.txt').split

def calculate(mass)
  (mass / 3) - 2
end

puts input.map { |mass| calculate(mass.to_i) }.reduce(&:+)
