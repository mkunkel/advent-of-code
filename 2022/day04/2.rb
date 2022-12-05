#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

pairs = File.read('2022/day04/input.txt').split("\n").map { |pair| pair.split(',') }

pairs.map! { |pair| pair.map { |elf| elf.split('-') }.map { |ids| (ids[0]..ids[1]).to_a } }

pairs.map! { |pair| pair.sort { |a, b| a.count <=> b.count } }

fully_contained = pairs.select { |pair| pair[0].any? { |section| pair[1].include?(section) } }

puts fully_contained.count
