#!/bin/bash -e

most=0

read item
while [[ $item != '' ]]; do
    calories=0

    while [[ $item != '' ]]; do
        calories=$(( $calories + $item ))
        read item
    done

    if (( $calories > $most )); then
        most=$calories
    fi

    read item
done

echo $most
