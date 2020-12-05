#! /usr/bin/env ruby
start = Time.new
class Array
  def split(value = '')
    arr = dup
    result = []
    while (idx = arr.index(value))
      result << arr.shift(idx)
      arr.shift
    end
    result << arr
  end
end

class Passport
  def initialize(text)
    @passport = parse(text)
  end

  def parse(text)
    attrs = text.split
    attrs.each_with_object({}) do |attr, hash|
      key, value = attr.split(':')
      hash[key] = value
    end
  end

  def validate
    %w(byr iyr eyr hgt hcl ecl pid).all? { |key| @passport.has_key?(key) }
  end
end

lines = File.read('2020/day04/input.txt').split("\n")
passports = lines.split.map { |passport| passport.join(' ') }

validations = passports.map do |passport|
  Passport.new(passport).validate
end

puts validations.count { |validation| validation }

finish = Time.new
puts "Time to run: #{(finish - start) * 1000}ms" # convert to microseconds
