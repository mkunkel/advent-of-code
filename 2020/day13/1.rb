#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

time, bus_ids = File.read('2020/day13/input.txt').split("\n")
bus_ids = bus_ids.split(',').reject { |bus_id| bus_id == 'x' }
times = bus_ids.map { |bus_id| bus_id.to_i - (time.to_i % bus_id.to_i) }

departs = times.min
bus = bus_ids[times.index(departs)].to_i

puts bus * departs
