#! /usr/bin/env elixir

defmodule Rocket do
  def module_fuel(module) do
    fuel = Kernel.trunc(module / 3) - 2
    if fuel > 0 do
      fuel + module_fuel(fuel)
    else
      0
    end
  end
end

modules = File.read!("day01/input.txt")
          |> String.trim()
          |> String.split("\n")
          |> Enum.map(fn x ->
               Integer.parse(x)
               |> elem(0)
             end)

  total = Enum.map(modules, fn x ->
            Rocket.module_fuel(x)
          end)
          |> Enum.reduce(fn x, acc -> x + acc end)

  IO.puts(total)
