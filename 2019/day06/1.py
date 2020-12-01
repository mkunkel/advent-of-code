#! /usr/bin/env python3
file = open("day06/input.txt", "r")
orbits = file.read().splitlines()
file.close()

planets = {}

for orbit in orbits:
    around, orbiting = orbit.split(")")
    planets[orbiting] = around

count = 0
for key in planets:
    while True:
        count += 1
        key = planets[key]
        if key == 'COM':
            break

print(count)
