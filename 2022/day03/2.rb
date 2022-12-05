#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

class Group
  PRIORITIES = [nil] + ('a'..'z').to_a + ('A'..'Z').to_a

  def initialize(content_groups)
    @content_groups = content_groups.map(&:chars)
  end

  def common
    @content_groups.reduce(:&).first
  end

  def sum
    PRIORITIES.index(common)
  end
end

groups = File.read('2022/day03/input.txt').split("\n").each_slice(3).map { |group| Group.new(group) }

puts groups.map { |group| group.sum }.sum
