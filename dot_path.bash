#!/bin/bash

while read -r line; do
    export PATH="$PATH:$line"
done < "path_file.txt"
