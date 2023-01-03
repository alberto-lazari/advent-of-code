#!/usr/bin/env bash
set -eu

for i in {0..2}; do
    top3[$i]=0
done

read item
while [[ $item != '' ]]; do
    calories=0

    while [[ $item != '' ]]; do
        calories=$(bc -e "$calories + $item")
        read item
    done

    top=0
    found=0
    while [[ $(bc -e "$top <= 2") = 1 && $found = 0 ]]; do
        if [[ $(bc -e "$calories >= ${top3[$top]}") = 1 ]]; then
            found=1
            i=2
            while [[ $(bc -e "$i >= $top") = 1 ]]; do
                if [[ $i = $top ]]; then
                    top3[$i]=$calories
                else
                    index=$(bc -e "$i - 1")
                    top3[$i]=${top3[$index]}
                fi

                i=$(bc -e "$i - 1")
            done
        fi

        top=$(bc -e "$top + 1")
    done

    read item
done

echo $(bc -e "${top3[0]} + ${top3[1]} + ${top3[2]}")
