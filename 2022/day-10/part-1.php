<?php
$cycle = 1;
$register = 1;
$sum = 0;
$addx = false;

$stdin = fopen("php://stdin", "r");
while (!feof($stdin)) {
    // echo "Cycle $cycle\n";

    if (($cycle - 20) % 40 == 0) {
        // echo "X = $register\n";
        $sum += $cycle * $register;
    }

    if (!$addx) {
        // Who tf came up with the function name 'explode'??
        $line = explode(' ', fgets($stdin));
        $op = $line[0];

        if ($op == 'addx') {
            $addx = true;
            $value = $line[1];

            // echo "  $op $value";
        }
        // else echo "  noop\n";
    }
    else {
        $register += $value;
        $addx = false;
    }

    $cycle++;
}
fclose($stdin);

echo "$sum\n";
?>
