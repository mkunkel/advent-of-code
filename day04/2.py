#! /usr/bin/env python
import re
def is_ascending(string):
    return ''.join(sorted(string)) == string

def has_repeat(string):
    for x in str(range(10)):
        if (x * 2 in string) and (x * 3 not in string):
            return True
    return False

def is_valid(number):
    string = str(number)
    return bool(has_repeat(string) and is_ascending(string))

begin = 236491
finish = 713787
count = 0

for x in range(begin, finish + 1):
    if is_valid(x):
        count += 1

print count
