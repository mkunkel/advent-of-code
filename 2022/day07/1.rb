#! /usr/bin/env ruby
require 'awesome_print'
require 'pry'

@current_directory = []
@structure = {}

# Monkey patches for Hash to allow access by array of keys
class Hash
  def set_by_array(array, value)
    if array.length == 1
      self[array[0]] = value
    else
      dig(*array[0..-2])[array[-1]] = value
    end
  end

  def get_by_array(array)
    dig(*array)
  end
end

def cd(dir)
  if dir == '..'
    @current_directory.pop
  else
    @current_directory << dir
    @structure.set_by_array(@current_directory, {})
  end
  pwd
end

def ls(dir)
  nil
end

def pwd
  @current_directory.join('/').gsub('//', '/')
end

def add_item(name, detail)
  path = @current_directory.dup << name
  if detail == 'dir'
    @structure.set_by_array(path, {})
  else
    @structure.set_by_array(path, detail.to_i)
  end
end

def collect_sizes(hash, values = {}, current_key = nil)
  values[current_key] = 0
  hash.keys.each do |key|
    if hash[key].is_a?(Hash)
      next_key = [current_key, key].compact.join('->')
      collect_sizes(hash[key], values, next_key)
      values[current_key] += values[next_key]
    elsif current_key
      values[current_key] += hash[key]
    end
  end
  values
end

lines = File.read('2022/day07/input.txt').split("\n")

# Build directory structure
lines.each do |line|
  if line[0] == '$'
    command, argument = line.gsub('$ ', '').split(' ')
    send(command.to_sym, argument)
  else
    detail, name = line.split(' ')
    add_item(name, detail)
  end
end

# Collect directory sizes
dir_sizes = collect_sizes(@structure)
puts dir_sizes.values.select { |value| value <= 100000 }.sum
