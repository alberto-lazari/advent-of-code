#!/bin/bash -e

# return the size of the passed directory
# size = files + size_of directories, if <= 100000
size_of() {
    local size=0

    for file in $1/*
    do
        if [[ -d $file ]]; then
            # needed not to run a subshell
            size_of $file > .temp
            size=$(( $size + $(cat .temp) ))
        else
            size=$(( $size + $(cat $file) ))
        fi
   done

   (( $size <= 100000 )) && computed_size=$(( $computed_size + $size ))
   echo $size
}

root="$PWD/root"

[[ -d $root ]] && rm -rf $root
mkdir $root

# evals the commands read form the input file, edited to create the actual tree
eval $(sed -e 's/^$ //' | sed -e "s|^cd /$|cd $root|" | sed -e 's/^dir/mkdir/' | sed -E 's/^([0-9]+) (.*)/echo \1 > \2/' | sed -E 's/^(.*)$/\1;/' | grep [^ls\;])

# result
computed_size=0
size_of $root > /dev/null

echo $computed_size

rm -rf $root
