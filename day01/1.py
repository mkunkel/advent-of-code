#! /usr/bin/env python
import math
file = open("day01/input.txt", "r")
modules = file.read().splitlines()
file.close()

fuel = 0
for module in modules:
    fuel = fuel + (math.floor(int(module) / 3)) - 2

print(int(fuel))
