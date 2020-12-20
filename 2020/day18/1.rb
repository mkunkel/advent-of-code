#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'



def process(equation)
  return do_maths(equation) unless equation.include?('(')
  open_parens = 0
  closed_parens = 0
  new_equation = ''
  parenthetical = ''

  equation.chars.each do |char|
    if char == '('
      open_parens += 1
      parenthetical << char
    elsif char == ')'
      closed_parens += 1
      parenthetical << char
      if open_parens == closed_parens
        new_equation += process(parenthetical[1..-2])
        open_parens = 0
        closed_parens = 0
        parenthetical = ''
      end
    else
      if open_parens == closed_parens
        new_equation += char
      else
        parenthetical << char
      end
    end
  end

  do_maths(new_equation)
end

def do_maths(equation)
  value, remaining = equation.match(/(\d+)(.*)/).captures
  value = value.to_i

  until remaining == ''
    operator, number, remaining = remaining.match(/(\D+)(\d+)(.*)/).captures
    value = value.send(operator.to_sym, number.to_i)
  end
  value.to_s
end

equations = File.read('2020/day18/input.txt').split("\n").map { |equation| equation.gsub(' ', '') }

puts equations.map { |equation| process(equation).to_i }.reduce(&:+)
