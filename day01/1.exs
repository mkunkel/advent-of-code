#! /usr/bin/env elixir

modules = File.read!("day01/input.txt")
          |> String.trim()
          |> String.split("\n")
          |> Enum.map(fn x ->
               Integer.parse(x)
               |> elem(0)
             end)

total = Enum.map(modules, fn x ->
          Kernel.trunc(x / 3) - 2
        end)
        |> Enum.reduce(fn x, acc -> x + acc end)

IO.puts(total)
