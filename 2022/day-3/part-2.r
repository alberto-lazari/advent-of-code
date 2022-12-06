rucksacks <- readLines('stdin')
sum <- 0

i <- 3
while (i <= length(rucksacks)) {
    elf <- list()
    for (j in 1:3) {
        elf[[j]] <- strsplit(rucksacks[i - j + 1], '')[[1]]
    }

    badge <- intersect(elf[[1]], intersect(elf[[2]], elf[[3]]))
    print(badge)

    badge <- utf8ToInt(badge)
    print(badge)

    if (badge >= utf8ToInt('a')) {
        sum <- sum + badge - utf8ToInt('a') + 1
    }
    else {
        sum <- sum + badge - utf8ToInt('A') + 27
    }

    i <- i + 3
}

print(sum)

