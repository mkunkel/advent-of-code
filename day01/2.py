#! /usr/bin/env python
import math
file = open("day01/input.txt", "r")
modules = file.read().splitlines()
file.close()

def module_fuel(module):
    value = (math.floor(int(module) / 3)) - 2
    if value > 0:
        return value + module_fuel(value)
    else:
        return 0

fuel = 0
for module in modules:
    fuel = fuel + module_fuel(module)

print(int(fuel))
