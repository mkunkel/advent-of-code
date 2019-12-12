#! /usr/bin/env ruby
require_relative '../day09/intcode'
require 'pry'

def create_loop(phases)
  phases.map { |phase| Intcode.new('day07/input.txt', phase) }
end

options = [5, 6, 7, 8, 9].permutation.to_a
highest_output = 0
counter = 1
highest_order = nil

options.each do |option|
  print "#{counter}/#{options.length} \r"
  $stdout.flush
  counter += 1
  signal = 0
  final_signal = false

  amplifiers = create_loop(option)

  while !final_signal do
    amplifiers.each do |amplifier|
      amplifier.add_input(signal)
      signal = amplifier.output
    end
    if amplifiers.last.completed
      final_signal = signal
    end
  end

  if final_signal > highest_output
    highest_output = final_signal
    highest_order = option
  end
end

# puts highest_output.to_s
puts "#{highest_order.join('')} produced #{highest_output.to_s}"
