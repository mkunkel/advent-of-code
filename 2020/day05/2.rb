#! /usr/bin/env ruby
start = Time.new

class BoardingPass
  def initialize(value)
    @value = value
  end

  def parse
    rows = (0..127).to_a
    cols = (0..7).to_a
    @value.chars.each do |letter|
      case letter
      when 'F'
        rows = rows.shift(rows.length / 2)
      when 'B'
        rows = rows.pop(rows.length / 2)
      when 'L'
        cols = cols.shift(cols.length / 2)
      when 'R'
        cols = cols.pop(cols.length / 2)
      end
    end
    @boarding_pass = { row: rows.first, col: cols.first }
  end

  def seat_id
    @boarding_pass[:row] * 8 + @boarding_pass[:col]
  end
end

lines = File.read('2020/day05/input.txt').split("\n")

ids = lines.map do |line|
  pass = BoardingPass.new(line)
  pass.parse
  pass.seat_id
end

missing = (0..ids.max).to_a - ids
puts missing.max

finish = Time.new
puts "Time to run: #{(finish - start) * 1000}ms" # convert to microseconds
