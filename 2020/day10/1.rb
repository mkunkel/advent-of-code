#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

adapters = File.read('2020/day10/input.txt').split("\n").map(&:to_i).sort
used_adapters = [0]
jolts = 0
built_in_adapter = 3

adapters.each do |adapter|
  if adapter >= jolts + 1 && adapter <= jolts + 3
    jolts = adapter
    used_adapters << adapter
  end
end

used_adapters << jolts + built_in_adapter

diffs = { '1' => 0, '2' => 0, '3' => 0 }
i = 1
while i < used_adapters.length do
  diff = used_adapters[i] - used_adapters[i - 1]
  diffs[diff.to_s] += 1
  i += 1
end

puts diffs['1'] * diffs['3']
