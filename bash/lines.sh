#!/bin/bash

# A prettier way to display the number of lines in a file than the default `wc -l command`. This one was mostly just for fun so there's no error handling or anything.

file=$1

lines=$(printf "%'d" $(wc -l $file | cut -d " " -f1))

echo "The file $file contains $lines lines."