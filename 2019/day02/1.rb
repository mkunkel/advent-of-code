#! /usr/bin/env ruby
input = File.read('day02/input.txt').split(',').map(&:to_i)

input[1] = 12
input[2] = 2

input.each_slice(4) do |slice|
  case slice[0]
  when 99
    puts input[0]
    exit 0
  when 1
    input[slice[3]] = input[slice[1]] + input[slice[2]]
  when 2
    input[slice[3]] = input[slice[1]] * input[slice[2]]
  end
end
