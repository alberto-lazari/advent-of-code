#!/usr/bin/env bash
set -eu

# return the size of the passed directory
# size = files + size_of directories, if <= 100000
size_of() {
    local size=0

    for file in $1/*
    do
        if [[ -d $file ]]; then
            dir_size=$(size_of $file)
            # not to throw an error, otherwise bash evaluates '> $file/.size'
            # even if $file is indeed a file, instead of a directory
            eval "echo $dir_size > $file/.size"
            size=$(bc -e "$size + $dir_size")
        else
            size=$(bc -e "$size + $(cat $file)")
        fi
   done

   echo $size
}

least_to_free_in () {
    least=$root_size

    for file in $1/*
    do
        if [[ -d $file ]]
        then
            dir_least=$(least_to_free_in $file)
            [[ $(bc -e "($dir_least >= $to_free) * ($dir_least < $least)") == 1 ]] && least=$dir_least
        fi
    done

    [[ $least == $root_size ]] && least=$(cat $1/.size)

    echo $least
}

root="$PWD/root"

[[ -d $root ]] && rm -rf $root
mkdir $root

# evals the commands read form the input file, edited to create the actual tree
eval $(sed -e 's/^$ //' | sed -e "s|^cd /$|cd $root|" | sed -e 's/^dir/mkdir/' | sed -E 's/^([0-9]+) (.*)/echo \1 > \2/' | sed -E 's/^(.*)$/\1;/' | grep [^ls\;])

root_size=$(size_of $root)
to_free=$(bc -e "30000000 - (70000000 - $root_size)")

least_to_free_in $root

rm -rf $root

