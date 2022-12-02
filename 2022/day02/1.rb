#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

plays = File.read('2022/day02/input.txt').split("\n")

# Create arrays to turn plays into index numbers for later comparison
his = %w(A B C)
mine = %w(X Y Z)

plays = plays.map do |play|
  him, me = play.split(' ')
  { me: me, him: him }
end

# This array will later be used for applying the result of modulo to determine score
scores = [3, 6, 0]

results = plays.map do |play|
  my_index = mine.index(play[:me])
  his_index = his.index(play[:him])

  # The score for the option selected is 1 higher than the index in the array
  selected = my_index + 1

  # Compare plays and convert to an index that gives our score
  resulting_index = (my_index - his_index) % 3
  selected + scores[resulting_index]
end

puts results.sum
