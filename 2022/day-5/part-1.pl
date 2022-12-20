use warnings;
use strict;

# split input string in characters
my @input = split //, <STDIN>;

# stacks initialization
my @stacks;
for (0..int((scalar @input + 1) / 4) - 1) {
    push @stacks, ([]);
}

while ($input[1] =~ m/[A-Z]| /) {
    for (0..@stacks - 1) {
        my $crane = $input[$_ * 4 + 1];
        
        if ($crane ne ' ') {
            push @{$stacks[$_]}, $crane;
        }
    }

    @input = split //, <STDIN>;
}

foreach my $stack (@stacks) {
    print @$stack, "\n";
}

