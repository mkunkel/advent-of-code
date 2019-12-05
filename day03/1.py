#! /usr/bin/env python3
from operator import methodcaller

def to_dict(move):
    return {
        'direction': move[0],
        'distance': int(move[1:])
    }

def to_directions(moves):
    return to_dict(moves)

def to_path(directions):
    velocity = {
    'R': [1, 0],
    'L': [-1, 0],
    'U': [0, 1],
    'D': [0, -1]
    }
    coords = [[0, 0]]
    for move in directions:
        for _ in range(move['distance']):
            coord = [x + y for x, y in zip(velocity[move['direction']], coords[-1])]
            coords.append(coord)
    return coords

def to_paths(line):
    line = line.split(',')
    directions = map(to_directions, line)
    return to_path(directions)

def intersection(lst):
    tup1 = list(map(tuple, lst[0]))
    tup2 = list(map(tuple, lst[1]))
    return list(map(list, set(tup1).intersection(tup2)))

def distance(coords):
    return abs(coords[0]) + abs(coords[1])

def closest(paths):
    common = intersection(paths)
    common.remove([0, 0])
    return min(map(distance, common))

file = open("day03/input.txt", "r")
lines = file.read().splitlines()
file.close()

paths = list(map(to_paths, lines))

print(closest(paths))
