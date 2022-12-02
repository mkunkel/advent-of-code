#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

plays = File.read('2022/day02/input.txt').split("\n")
# Create arrays to turn plays into index numbers for later comparison
options = %w(A B C)

# The index values of this array represent how to change the index of his play
# to achieve the desired result
modifiers = %w(Y Z X)

plays = plays.map do |play|
  him, me = play.split(' ')
  # Alter my play to create the result desired
  modifier = modifiers.index(me)
  his_index = options.index(him)
  me = options[(his_index + modifier) % 3]
  { me: me, him: him }
end


# Now score just like in part 1, but

# This array will later be used for applying the result of modulo to determine score
scores = [3, 6, 0]

results = plays.map do |play|
  # binding.pry
  my_index = options.index(play[:me])
  his_index = options.index(play[:him])

  # The score for the option selected is 1 higher than the index in the array
  selected = my_index + 1

  # Compare plays and convert to an index that gives our score
  resulting_index = (my_index - his_index) % 3
  selected + scores[resulting_index]
end

puts results.sum
