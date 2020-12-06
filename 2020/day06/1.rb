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

groups = File.read('2020/day06/input.txt').split("\n").split

counts = groups.map do |group|
  group.join.chars.uniq.count
end

puts counts.reduce(&:+)

finish = Time.new
puts "Time to run: #{(finish - start) * 1000}ms" # convert to microseconds
