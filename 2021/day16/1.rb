#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'
hex = File.read('2021/day16/input.txt').chomp.chars
values = %w(0 1 2 3 4 5 6 7 8 9 A B C D E F)
binary = values.map.with_index { |x, i| i.to_s(2).rjust(4, '0') }
HEX_TO_BINARY = {}
BINARY_TO_HEX = {}
@total_version = 0

values.length.times.map.with_index do |i|
  HEX_TO_BINARY[values[i]] = binary[i]
  BINARY_TO_HEX[binary[i]] = values[i]
end

# Length represents number of subpackets
def odd(packets, length)
  length = packets.shift(length).join.to_i(2)
  values = []
  length.times do
    values << process(packets)
  end
  values
end

# literal/not operator
def literal(packets, _length)
  str = ''
  should_break = false
  until should_break do
    should_break = packets.shift == '0'
    packet = packets.shift(4).join
    str << packet
  end
  str.to_i(2)
end

# Length represents total length of subpackets
def even(packets, length)
  length = packets.shift(length).join.to_i(2)
  original_length = packets.length
  value = []
  until original_length - packets.length == length || packets.empty? do
    value << process(packets)
  end
  value
end

def process(packets)
  return if packets.empty?
  version = packets.shift(3).join.rjust(4, '0').to_i(2)
  type_id = packets.shift(3).join.rjust(4, '0').to_i(2)
  length = packets.shift == '0' ? 15 : 11 unless type_id == 4

  @total_version = @total_version + version

  if type_id == 4
    literal(packets, length)
  else
    type_id.even? ? even(packets, length) : odd(packets, length)
  end
end

packets = hex.map { |h| HEX_TO_BINARY[h] }.join.chars

process(packets)
puts @total_version
