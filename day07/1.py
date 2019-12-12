#! /usr/bin/env python3

from itertools import permutations
import subprocess
import sys

options = list(permutations(['5', '6', '7', '8', '9']))

highest_output = 0
counter = 1
for option in options:
    sys.stdout.write("{}/{} \r".format(counter, len(options)))
    sys.stdout.flush()
    counter += 1
    signal = 0
    for argument in option:
        argument = "{},{}".format(argument, signal)
        signal = subprocess.run(["day07/amplifier.rb", argument], stdout=subprocess.PIPE, universal_newlines=True).stdout

    if int(signal) > int(highest_output):
        highest_output = signal
        highest_order = option

print("{0} produced {1}".format(''.join(highest_order), highest_output))
