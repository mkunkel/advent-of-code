#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def play(player1, player2)
  card1 = player1.shift
  card2 = player2.shift
  if card1 > card2
    player1 << card1
    player1 << card2
  else
    player2 << card2
    player2 << card1
  end
  score = check_score(player1, player2)
  score ? score : play(player1, player2)
end

def check_score(player1, player2)
  return false unless player1.empty? || player2.empty?
  cards = player1.push(player2).flatten.reverse
  (1..cards.count).reduce do |memo, number|
    memo += cards[number - 1] * number
  end
end

player1, player2 = File.read('2020/day22/input.txt').split("\n\n").map { |player| player.split("\n")[1..-1].map(&:to_i) }

puts play(player1, player2)
