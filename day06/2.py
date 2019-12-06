#! /usr/bin/env python3
def find_orbits(orbits, key):
    path = []

    while True:
        key = orbits[key]
        path.append(key)
        if key == 'COM':
            break
    return path

def first_common(path_1, path_2):
    for item in path_1:
        try:
            common = path_2.index(item)
            return common
        except ValueError:
            continue

def count_steps(path_1, path_2):
    common = first_common(path_1, path_2)
    count =  path_1.index(path_2[common]) + common

    return count

file = open("day06/input.txt", "r")
orbits = file.read().splitlines()
file.close()

planets = {}

for orbit in orbits:
    around, orbiting = orbit.split(")")
    planets[orbiting] = around

santa_orbits = find_orbits(planets, "SAN")
you_orbits = find_orbits(planets, "YOU")

count = count_steps(santa_orbits, you_orbits)
print(count)
