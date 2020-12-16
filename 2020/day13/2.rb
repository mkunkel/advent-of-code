#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def depart(busses, increment, start)
  final_departure = nil
  timestamp = start

  until final_departure do
    final_departure = timestamp if busses.all? { |b| (timestamp + b[:index]) % b[:bus] == 0 }
    timestamp += increment
  end

  final_departure
end

_time, bus_ids = File.read('2020/day13/input.txt').split("\n")
bus_ids = bus_ids.split(',').map { |bus_id| bus_id == 'x' ? 'x' : bus_id.to_i }

modified = bus_ids.map.with_index do |bus_id, index|
  if bus_id == 'x'
    'x'
  else
    { bus: bus_id, index: index }
  end
end

modified.reject! { |mod| mod == 'x' }

increment = modified.first[:bus]
busses = [modified.shift, modified.shift]
start = depart(busses, increment, 0)
modified.each do |bus|
  increment = busses[0..-1].map { |bus| bus[:bus] }.reduce(&:*)
  busses << bus
  start = depart(busses, increment, start)
end

puts start
