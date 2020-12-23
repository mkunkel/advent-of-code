#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

def play(player1, player2, rounds = [], game = 1, sub_game = 1)
  round = [player1.join, player2.join]
  if rounds.include?(round)
    winner = 3
  else
    rounds << round
    card1 = player1.shift
    card2 = player2.shift
    winner = if card1 <= player1.count && card2 <= player2.count
      sub_game += 1
      play(player1.take(card1), player2.take(card2), [], sub_game, sub_game)[:winner]
    elsif (player1.count < card1 && player2.count < card2) || (player1.count <= card1 && player2.count <= card2)
      value = card1 > card2 ? 1 : 2
      value
    elsif card2.nil? || player1.count <= card1
      1
    elsif card1.nil? || player2.count <= card2
      2
    end
  end

  if winner == 1
    player1 << card1 unless card1.nil?
    player1 << card2 unless card2.nil?
  elsif winner == 2
    player2 << card2 unless card2.nil?
    player2 << card1 unless card1.nil?
  else
    player2 = []
  end

  score = check_score(player1, player2)
  score ? score : play(player1.dup, player2.dup, rounds, game, sub_game)
end

def check_score(player1, player2)
  return false unless player1.empty? || player2.empty?
  winner = player1.empty? ? 2 : 1
  cards = player1.push(player2).flatten.reverse
  score = cards.map.with_index { |card, index| card * (index + 1) }.reduce(&:+)
  { winner: winner, score: score }
end

player1, player2 = File.read('2020/day22/input.txt').split("\n\n").map { |player| player.split("\n")[1..-1].map(&:to_i) }

puts play(player1, player2)
