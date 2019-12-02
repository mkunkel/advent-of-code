#! /usr/bin/env ruby

input = File.read('day01/input.txt').split.map(&:to_i)

def calculate(mass)
  (mass / 3) - 2
end

fuel = input.map do |mod|
  f = [calculate(mod)]
  while f.last > 0 do
    break unless calculate(f.last) > 0
    f << calculate(f.last)
  end
  f.reduce(&:+)
end.reduce(&:+)

puts fuel
