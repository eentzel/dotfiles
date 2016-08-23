#!/bin/sh

# Given a CSV (or optionally TSV) on STDIN,
# print the "fill rate" (meaning the number of rows where that column is not blank) for each column

# BUGS: works great unless there are quoted fields with a comma in them :(

awk -F, '{for (i=0; i<=NF; i++) if ($i) counts[i]++} END {for (c in counts) print c, counts[c]}'
