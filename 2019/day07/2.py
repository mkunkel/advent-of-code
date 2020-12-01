#! /usr/bin/env python3

from itertools import permutations
import subprocess
import sys

def feedback_loop(processes, signal):
    for process in processes:
        process.stdin.write(signal)
        signal = process.stdout.read()
        print(signal)

    print(process[-1].poll())
    feedback_loop(processes, signal)

options = list(permutations(['5', '6', '7', '8', '9']))

highest_output = 0
counter = 1
for option in options:
    sys.stdout.write("{}/{} \r".format(counter, len(options)))
    sys.stdout.flush()
    counter += 1
    signal = 0
    processes = []
    for argument in option:
        argument = "{},{}".format(argument, signal)
        process = subprocess.Popen(["day07/amplifier.rb", argument], stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE, universal_newlines=True)
        signal = process.stdout.read()
        print(signal)

    output = feedback_loop(processes, signal)

    if int(output) > int(highest_output):
        highest_output = signal
        highest_order = option

print("{0} produced {1}".format(''.join(highest_order), highest_output))
