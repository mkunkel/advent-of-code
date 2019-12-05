#! /usr/bin/env python3
import re
def is_ascending(string):
    return ''.join(sorted(string)) == string

def has_repeat(string):
    return bool(re.search(r"(\d)\1+", string))

def is_valid(number):
    string = str(number)
    return bool(has_repeat(string) and is_ascending(string))

begin = 236491
finish = 713787
count = 0

for x in range(begin, finish + 1):
    if is_valid(x):
        count += 1

print(count)
