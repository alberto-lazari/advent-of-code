#!/usr/bin/env bash
set -eu

fpc part-$1.pas 1> /dev/null && rm part-$1.o
./part-$1

