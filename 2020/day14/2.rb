#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

class Bitmasker
  DEFAULT_VALUE = '000000000000000000000000000000000000'

  def initialize(file_path)
    @file_path = file_path
    @memory = {}
  end

  def apply_mask(value)
    string = value.to_i.to_s(2).rjust(36, '0')
    chars = string.chars
    new_mask = @mask.chars.map.with_index do |char, index|
      char == '0' ? chars[index] : char
    end.join
    permutations(new_mask)
  end

  def permutations(string)
    floating_count = string.count('X')
    options = ['0', '1'].repeated_permutation(floating_count)
    options.map do |option|
      new_string = string.dup
      floating_count.times do |time|
        index = new_string.index('X')
        new_string[index] = option.shift
      end
      new_string.to_i(2)
    end
  end

  def update_mask(string)
    @mask = string.gsub('mask = ', '')
  end

  def process
    File.readlines(@file_path).each do |line|
      if line.length > DEFAULT_VALUE.length
        update_mask(line)
      else
        location, value = line.match(/mem\[(\d+)\] = (\d+)/).captures
        positions = apply_mask(location)
        positions.each do |position|
          @memory[position] = value.to_i
        end
      end
    end
  end

  def total
    @memory.values.reduce(&:+)
  end
end



file_path = '2020/day14/input.txt'

bitmasker = Bitmasker.new(file_path)
bitmasker.process
puts bitmasker.total
