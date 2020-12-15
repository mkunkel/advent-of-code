#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

class Bitmasker
  DEFAULT_VALUE = '000000000000000000000000000000000000'

  def initialize(lines)
    @lines = lines
    @memory = []
  end

  def apply_mask(value)
    string = value.to_i.to_s(2).rjust(36, '0')
    chars = string.chars
    @mask.chars.map.with_index do |char, index|
      char == 'X' ? chars[index] : char
    end.join
  end

  def update_mask(string)
    @mask = string.gsub('mask = ', '')
  end

  def process
    @lines.each do |line|
      if line.length > DEFAULT_VALUE.length
        update_mask(line)
      else
        position, value = line.match(/mem\[(\d+)\] = (\d+)/).captures
        @memory[position.to_i] = apply_mask(value)
      end
    end
  end

  def total
    @memory.map { |value| value.nil? ? 0 : value.to_i(2) }.reduce(&:+)
  end
end



lines = File.read('2020/day14/input.txt').split("\n")

bitmasker = Bitmasker.new(lines)
bitmasker.process
puts bitmasker.total
