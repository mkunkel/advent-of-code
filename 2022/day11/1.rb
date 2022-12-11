#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

class Barrel
  attr_reader :monkeys
  def initialize
    @monkeys = []
  end

  def start_round
    @monkeys.each do |monkey|
      until monkey.items.empty? do
        # result will be a hash with the item and receiving monkey
        result = monkey.inspect_item
        @monkeys[result[:monkey]] << result[:item]
      end
    end
  end

  def <<(monkey)
    raise ArgumentError unless monkey.is_a?(Monkey)
    @monkeys << monkey
  end

  def monkey_business
    most_active.reduce(&:*)
  end

  private

  def most_active
    @monkeys.map(&:thrown).max(2)
  end
end


class Monkey
  attr_reader :items, :thrown

  def initialize(attributes)
    @thrown = 0
    parse(attributes)
  end

  def <<(item)
    @items << item
  end

  def inspect_item
    # The item is actually the "old" worry level
    old = @items.shift
    # Eval is evil, sort of.
    new_worry = eval(@operation)

    # lose interest before throwing
    new_worry = (new_worry / 3).floor
    throw_item(new_worry)
  end

  private

  def throw_item(item)
    # increment thrown counter
    @thrown += 1
    { item: item, monkey: test(item) }
  end

  def test(item)
    item % @modulo == 0 ? @if_true : @if_false
  end

  def parse(attributes)
    @items = attributes.match(/Starting items: (.*)$/).captures.first.split(', ').map(&:to_i)
    @operation = attributes.match(/Operation: new = (.*)$/).captures.first
    @modulo = attributes.match(/Test: divisible by (\d*)$/).captures.first.to_i
    @if_true = attributes.match(/If true: throw to monkey (\d*)$/).captures.first.to_i
    @if_false = attributes.match(/If false: throw to monkey (\d*)$/).captures.first.to_i
  end
end

line_groups = File.read('2022/day11/input.txt').split("\n\n")

barrel = Barrel.new

line_groups.each { |line_group| barrel << Monkey.new(line_group) }

20.times { barrel.start_round }

puts barrel.monkey_business
