rucksacks <- readLines('stdin')
sum <- 0

for (rucksack in rucksacks) {
    rucksack <- strsplit(rucksack, '')[[1]]
    size <- length(rucksack)
    r.left <- rucksack[1 : (size / 2)]
    r.right <- rucksack[(size / 2 + 1) : size]

    wrong <- utf8ToInt(intersect(r.left, r.right)[1])
    print (wrong)

    if (wrong >= utf8ToInt('a')) {
        sum <- sum + wrong - utf8ToInt('a') + 1
    }
    else {
        sum <- sum + wrong - utf8ToInt('A') + 27
    }
}

print(sum)

