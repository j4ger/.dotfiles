#!/bin/bash

while read -r line; do
    export PATH="$PATH:$line"
done < "$HOME/.pathrc"
