#!/usr/bin/env python

# Call me with one arg, the path to a LinkedIn Connections CSV export file

import csv
import itertools
import sys

def load_connections(filename):
    with open(filename) as input:
        return [l for l in csv.DictReader(input)]

def company(c):
    return c.get('Company')

def companies(c):
    return [x for x in itertools.groupby(sorted(c, key=company), company)]

def main():
    connections = load_connections(sys.argv[1])
    # print connections[0]['Company']
    # print connections[0].get('Company')
    print [c for c in companies(connections)]

if __name__ == '__main__':
    main()
