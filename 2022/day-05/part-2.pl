use warnings;
use strict;

# split input string in array of characters
my @input = split //, <STDIN>;

# stacks initialization
my @stacks;
for (1 .. int ((scalar @input + 1) / 4)) {
    push @stacks, ([]);
}

# while the final row " 1   2   3..." is not encountered
while ($input[1] =~ m/[A-Z]| /) {
    for (0 .. @stacks - 1) {
        # index exactly the character representing the crane
        my $crane = $input[$_ * 4 + 1];

        if ($crane ne ' ') {
            push @{$stacks[$_]}, $crane;
        }
    }

    @input = split //, <STDIN>;
}

# read blank line
scalar <STDIN>;

for my $input (<STDIN>) {
    chomp $input;
    my @step = split / /, $input;
    
    my $move = $step[1];
    my $from = $step[3] - 1;
    my $to = $step[5] - 1;

    my @cranes;
    for (1 .. $move) {
        push @cranes, shift @{$stacks[$from]};
    }
    unshift @{$stacks[$to]}, @cranes;
}

# print the final result
for my $stack (@stacks) {
    print ${$stack}[0];
}

print "\n";
