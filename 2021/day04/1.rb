#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def mark_board(board, called)
  board.dup.map do |row|
    row.map do |char|
      called.include?(char) ? 'x' : char
    end
  end
end

def winner?(board, called)
  marked_board = mark_board(board, called)
  return true if marked_board.any? { |row| row.uniq == ['x'] }
  return true if marked_board.transpose.any? { |row| row.uniq == ['x'] }
  false
end

def score_board(board, called)
  board.dup.flatten.reject { |number| called.include?(number) }.map(&:to_i).reduce(&:+)
end

lines = File.read('2021/day04/input.txt')

numbers, *boards = lines.split("\n\n")

numbers = numbers.split(',')
boards = boards.map { |board| board.split("\n").map { |line| line.split(' ') } }

called = []
score = 0

while score == 0 do
  called << numbers.shift
  boards.each do |board|
    score = score_board(board, called) if winner?(board, called)
  end
end

puts called.last.to_i * score
