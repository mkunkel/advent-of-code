#! /usr/bin/env ruby
def process(n, v)
  input = File.read('day02/input.txt').split(',').map(&:to_i)

  input[1] = n
  input[2] = v

  input.each_slice(4) do |slice|
    case slice[0]
    when 99
      return input[0]
    when 1
      input[slice[3]] = input[slice[1]] + input[slice[2]]
    when 2
      input[slice[3]] = input[slice[1]] * input[slice[2]]
    end
  end
end

numbers = (0..99).to_a

numbers.each do |noun|
  numbers.each do |verb|
    value = process(noun, verb)
    if value == 19690720
      puts "Value: #{value}"
      puts "Noun: #{noun}"
      puts "Verb: #{verb}"
      puts "Total: #{100 * noun + verb}"
    end
  end
end
