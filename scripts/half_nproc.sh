#!/usr/bin/env bash
n=$(nproc)

if (( n <= 1 )); then
    echo 1
else
    echo $(( n / 2 ))
fi
