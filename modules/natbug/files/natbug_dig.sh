#!/bin/bash

i=0
while true; do
    (( i++ ))
    echo
    echo "Query #$i"
    dig +noall +answer "$1"
    sleep 0.1
done
