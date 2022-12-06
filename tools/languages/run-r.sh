#!/usr/bin/env bash
set -eu

Rscript part-$1.r &> interpreter.log

# Print the result only, in a standard format
tac interpreter.log | head -n 1 | sed 's/^\[[0-9]*\] //'

