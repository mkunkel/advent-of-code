#! /usr/bin/env elixir

# defmodule Intcode do
#   def operations(list) do
#     Enum.chunk_every(list, 4)
#   end
#
#   def update_list(list, [op, one, two, pos]) do
#     val1 = Enum.at(list, Enum.at(list, one))
#     val2 = Enum.at(list, Enum.at(list, two))
#
#     case op do
#       99 ->
#         IO.puts list
#         exit(:shutdown)
#       1 ->
#         List.update_at(list, pos, fn (_c) -> val1 + val2 end)
#       2 ->
#         List.update_at(list, pos, fn (_c) -> val1 * val2 end)
#     end
#   end
#
#   def update_list(list, op) do
#     IO.inspect op
#     IO.inspect list
#   end
#
#   def execute(list) do
#     operations(list)
#     |>
#   end
# end
#
#
# numbers = File.read!("day02/input.txt")
#           |> String.trim()
#           |> String.split(",")
#           |> Enum.map(fn x ->
#                String.to_integer(x)
#              end)
#
# Intcode.execute(numbers)
