#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

lines = File.read('2024/day02/input.txt').split("\n")
lines.map! { |line| line.split(' ').map(&:to_i) }

total = 0

def is_safe?(line)
  line.each_cons(2).to_a.all? do |a, b|
    diff = (a - b).abs
    diff > 0 && diff < 4
  end && (line.sort == line || line.sort == line.reverse)
end

def line_safe?(line)
  result = is_safe?(line) ? 'safe' : nil

  line.count.times do |i|
    break if result
    new_line = line.dup
    new_line.delete_at(i)

    is_safe = is_safe?(new_line)
    result = 'safe' if is_safe
  end

  result || 'unsafe'
end

lines.each do |line|
  result = 'safe'
  if (line.sort == line || line.sort == line.reverse) && line.uniq.count != line.count
    if line.count - line.uniq.count == 1
      line = line.uniq
      result = 'modified'
    else
      result = 'unsafe'
    end
  elsif (line != line.sort && line != line.sort.reverse) && line.uniq.count != line.count
    line.count.times do |i|
      new_line = line.dup
      new_line.delete_at(i)
      next if new_line.uniq.count != new_line.count
      if new_line == new_line.sort || new_line == new_line.sort.reverse
        line = new_line
        result = 'modified'
        break
      end
    end

    result = 'unsafe' unless result == 'modified'
  end
  result = 'unsafe' if line.uniq.count != line.count
  result = 'unsafe' unless is_safe?(line) if result == 'modified'
  result = line_safe?(line) if result == 'safe'

  result = 'safe' if result == 'modified'
  puts result.upcase
  total += 1 if result == 'safe'
end

puts total
