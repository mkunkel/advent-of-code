#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

lines = File.read('2020/day21/input.txt').split("\n")
allergen_ingredients = Hash.new { |h,k| h[k] = [] }
all_ingredients = []

lines.each do |line|
  ingredients, allergens = line.match(/^(.*)\(contains (.*)\)$/).captures
  ingredients = ingredients.split(' ')
  all_ingredients << ingredients
  allergens.split(', ').each { |allergen| allergen_ingredients[allergen] << ingredients }
end

allergen_ingredients.each do |k, v|
  allergen_ingredients[k] = v.reduce(&:&)
end

no_allergens = all_ingredients.flatten - allergen_ingredients.values.flatten
puts no_allergens.count
