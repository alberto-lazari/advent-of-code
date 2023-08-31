-module('part-1').
-export([start/0]).

spawn_monkey(N) when N < 4 ->
    StartingItems = [],
    Operation = fun(X) -> X end,
    Test = fun(X) -> X end,
    spawn(monkey, start, [N, StartingItems, Operation, Test]),
    spawn_monkey(N + 1);

spawn_monkey(_) -> done.

spawn_monkeys() -> spawn_monkey(0).

start() ->
    spawn_monkeys().
