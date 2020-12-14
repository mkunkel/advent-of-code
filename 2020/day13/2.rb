#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'
require 'prime'

def depart(busses, increment)
  start = 0
  final_departure = nil
  timestamp = start

  until final_departure do
    final_departure = timestamp if busses.all? { |b| (timestamp + b[:index]) % b[:bus] == 0 }
    timestamp += increment
  end

  puts final_departure
  final_departure
end

_time, bus_ids = File.read('2020/day13/input.txt').split("\n")
bus_ids = bus_ids.split(',').map { |bus_id| bus_id == 'x' ? 'x' : bus_id.to_i }

modified = bus_ids.map.with_index do |bus_id, index|
  if bus_id == 'x'
    'x'
  else
    { bus: bus_id, index: index, factors: bus_id.prime_division.map(&:first) }
  end
end

modified.reject! { |mod| mod == 'x' }
modified.sort! { |a, b| b[:bus] <=> a[:bus] }
# min = 100000000000000
# start = (min / head[:bus]).floor * head[:bus]
# binding.pry
increment = modified.first[:bus]


busses = []
increment = 1

modified.each do |bus|
  busses << bus
  increment = depart(busses, increment)
end

  puts increment

# mods = modified.map { |mod| mod[:bus] }
# remainders = modified.map { |mod| mod[:index] }
# modulo = remainders.reduce(&:*)
# modulos = mods.map { |mod| modulo / mod }

# # puts mods.to_s
# # puts remainders.to_s
# # puts chinese_remainder(mods, remainders)
