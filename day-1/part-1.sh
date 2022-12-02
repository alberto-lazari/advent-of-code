most=0

read item
while [[ $item != '' ]]; do
    calories=0

    while [[ $item != '' ]]; do
        calories=$(bc -e "$calories + $item")
        read item
    done

    if [[ $(bc -e "$calories > $most") = 1 ]]; then
        most=$calories
    fi

    read item
done

echo $most

