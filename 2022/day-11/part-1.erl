-module('part-1').
-export([start/0]).

-import(input, [starting_items/0, operation_fun/0, test_fun/0]).

spawn_monkeys(Monkeys) ->
    {ok, [N]} = io:fread("", "Monkey ~d:"),
    Pid = spawn(monkey, start, [N, starting_items(), operation_fun(), test_fun()]),
    Monkey = {N, Pid},

    case io:get_line("") of
        eof -> Monkeys ++ [Monkey];
        _   -> spawn_monkeys(Monkeys ++ [Monkey])
    end.

start() ->
    Monkeys = spawn_monkeys([]),
    [{0, Pid}|Rest] = Monkeys,
    Pid ! inspect.
