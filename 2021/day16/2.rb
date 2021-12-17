#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'
hex = File.read('2021/day16/input.txt').chomp.chars
values = %w(0 1 2 3 4 5 6 7 8 9 A B C D E F)
binary = values.map.with_index { |x, i| i.to_s(2).rjust(4, '0') }
HEX_TO_BINARY = {}
BINARY_TO_HEX = {}

values.length.times.map.with_index do |i|
  HEX_TO_BINARY[values[i]] = binary[i]
  BINARY_TO_HEX[binary[i]] = values[i]
end

# Length represents total length of subpackets
def total_length_of_subpackets(packets, length)
  length = packets.shift(length).join.to_i(2)
  original_length = packets.length
  values = []
  until original_length - packets.length == length || packets.empty? do
    values << process(packets)
  end
  values.compact
end

# Length represents number of subpackets
def number_of_subpackets(packets, length)
  length = packets.shift(length).join.to_i(2)
  values = []
  length.times do
    values << process(packets)
  end
  values.compact
end

def get_value(packets, length)
  length == 15 ? total_length_of_subpackets(packets, length) : number_of_subpackets(packets, length)
end

def code_0(packets, length)
  get_value(packets, length).sum
end

def code_1(packets, length)
  get_value(packets, length).reduce(&:*)
end

def code_2(packets, length)
  get_value(packets, length).min
end


def code_3(packets, length)
  get_value(packets, length).max
end

# literal/not operator
def code_4(packets, _length)
  str = ''
  should_break = false
  until should_break do
    should_break = packets.shift == '0'
    packet = packets.shift(4).join
    str << packet
  end
  str.to_i(2)
end

def code_5(packets, length)
  value = get_value(packets, length)
  value[0] > value[1] ? 1 : 0
end

def code_6(packets, length)
  value = get_value(packets, length)
  value[0] < value[1] ? 1 : 0
end

def code_7(packets, length)
  value = get_value(packets, length)
  value[0] == value[1] ? 1 : 0
end

def process(packets)
  return if packets.empty?
  version = packets.shift(3).join.rjust(4, '0').to_i(2)
  type_id = packets.shift(3).join.rjust(4, '0').to_i(2)
  length = packets.shift == '0' ? 15 : 11 unless type_id == 4

  send("code_#{type_id}", packets, length)
end

packets = hex.map { |h| HEX_TO_BINARY[h] }.join.chars

puts process(packets)
