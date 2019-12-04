#! /usr/bin/env ruby
def is_valid?(number)
  str = number.to_s
  is_ascending?(str) && has_repeat?(str)
end

def is_ascending?(str)
  str.chars.sort.join == str
end

def has_repeat?(str)
  (0..9).to_a.map(&:to_s).each do |num|
    return true if str.include?(num * 2) && !str.include?(num * 3)
  end
  return false
end


start = 236491
finish = 713787
count = 0

(start..finish).to_a.each do |int|
  count += 1 if is_valid?(int)
end

puts count
