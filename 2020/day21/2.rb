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

single_ingredients = allergen_ingredients.values.reject { |value| value.count > 1 }.flatten

while single_ingredients.count < allergen_ingredients.keys.count do
  allergen_ingredients.reject { |k, v| v.count == 1 }.each do |key, value|
    allergen_ingredients[key] = value.reject { |val| single_ingredients.include?(val) }
  end
  single_ingredients = allergen_ingredients.values.reject { |value| value.count > 1 }.flatten
end

list = allergen_ingredients.keys.sort.each_with_object([]) { |k, arr| arr << allergen_ingredients[k] }

puts list.join(',')
