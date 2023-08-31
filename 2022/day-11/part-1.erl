-module('part-1').
-export([start/0]).

read_items(Items, {ok, [","]}) ->
    {ok, Item} = io:fread("", "~d"),
    io:fwrite("~w~n", [Item]),
    [Items|Item];

read_items(Items, _) -> Items.

spawn_monkey(Num) when Num < 4 ->
    N = io:fread("", "Monkey ~d:"),
    StartingItems = read_items([io:fread("", "  Starting items: ~d")], io:fread("", "~s")),
    Operation = fun(X) -> X end,
    Test = fun(X) -> X end,
    spawn(monkey, start, [N, StartingItems, Operation, Test]),
    case io:fread("", "") of
        eof -> N;
        _ -> spawn_monkey(Num + 1)
    end;

spawn_monkey(N) -> N.

spawn_monkeys() -> spawn_monkey(0).

start() ->
    io:fwrite("~w mokeys spawned~n", [spawn_monkeys()]).
