#! /usr/bin/env ruby
require 'pry'

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
    return false unless %w(byr iyr eyr hgt hcl ecl pid).all? { |key| @passport.has_key?(key) }
    @passport.keys.all? { |key| send(key.to_sym) }
  end

  private

  def byr
    @passport['byr'].to_i >= 1920 && @passport['byr'].to_i <= 2002
  end

  def iyr
    @passport['iyr'].to_i >= 2010 && @passport['iyr'].to_i <= 2020
  end

  def eyr
    @passport['eyr'].to_i >= 2020 && @passport['eyr'].to_i <= 2030
  end

  def hgt
    height = @passport['hgt'].match(/^(\d{2,3})(cm|in)$/)
    return false if height.nil?
    number, measurement = height.captures
    case measurement
    when 'cm'
      number.to_i >= 150 && number.to_i <= 193
    when 'in'
      number.to_i >= 59 && number.to_i <= 76
    else
      false
    end
  end

  def hcl
    !@passport['hcl'].match(/^#[0-9a-f]{6}$/).nil?
  end

  def ecl
    %w(amb blu brn gry grn hzl oth).any? { |color| color == @passport['ecl'] }
  end

  def pid
    !@passport['pid'].match(/^\d{9}$/).nil?
  end

  def cid
    true
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
