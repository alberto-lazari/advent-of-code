#!/bin/bash -e

for i in {0..2}; do
    top3[$i]=0
done

read item
while [[ $item != '' ]]; do
    calories=0

    while [[ $item != '' ]]; do
        calories=$(( $calories + $item ))
        read item
    done

    top=0
    found=0
    while (( $top <= 2 )) && [[ $found = 0 ]]; do
        if (( $calories >= ${top3[$top]} )); then
            found=1
            i=2
            while (( $i >= $top )); do
                if [[ $i = $top ]]; then
                    top3[$i]=$calories
                else
                    index=$(( $i - 1 ))
                    top3[$i]=${top3[$index]}
                fi

                i=$(( $i - 1 ))
            done
        fi

        top=$(( $top + 1 ))
    done

    read item
done

echo $(( ${top3[0]} + ${top3[1]} + ${top3[2]} ))
