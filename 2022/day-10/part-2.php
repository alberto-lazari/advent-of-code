<?php
$cycle = 1;
$register = 1;
$addx = false;

$stdin = fopen('php://stdin', 'r');
while (!feof($stdin)) {

    $pixel = ($cycle - 1) % 40;
    if (($pixel >= $register - 1) && ($pixel <= $register + 1)) echo '#';
    else echo '.';

    if ($cycle % 40 == 0) echo "\n";

    if (!$addx) {
        // Who tf came up with the function name 'explode'??
        $line = explode(' ', fgets($stdin));
        $op = $line[0];

        if ($op == 'addx') {
            $addx = true;
            $value = $line[1];
        }
    }
    else {
        $register += $value;
        $addx = false;
    }

    $cycle++;
}
fclose($stdin);
?>
