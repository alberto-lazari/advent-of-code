-module('part-1').
-export([start/0]).

-import(input, [starting_items/0, operation_fun/0, test_fun/0]).

spawn_monkeys() ->
    {ok, [N]} = io:fread("", "Monkey ~d:"),
    spawn(monkey, start, [N, starting_items(), operation_fun(), test_fun()]),

    case io:get_line("") of
        eof -> N + 1;
        _   -> spawn_monkeys()
    end.

start() ->
    Monkeys = spawn_monkeys().
