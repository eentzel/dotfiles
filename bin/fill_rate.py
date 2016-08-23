#!/usr/bin/env python

# Given a CSV on stdin, print the "fill rate" (meaning the number of rows
# where that column is not blank) for each column
#
# Author: Eric Entzel <eric@ubermac.net>

from collections import defaultdict
import csv
import sys

def filled(s):
    return not s == ""

counts = defaultdict(int)
for line in csv.reader(sys.stdin):
    for i, col in enumerate(line):
        if filled(col):
            counts[i] += 1

nf = max(counts) + 1
print ",".join(str(counts[i]) for i in range(nf))
