-module('part-1').
-export([start/0]).

-import(input, [starting_items/0, operation_fun/0, test_fun/0]).

spawn_monkeys(Monkeys) ->
    {ok, [N]} = io:fread("", "Monkey ~d:"),
    Pid = spawn(
            monkey,
            start,
            [ [N, starting_items(), operation_fun(), test_fun(), erlang:self()] ]
           ),
    NewMonkeys = maps:put(N, Pid, Monkeys),

    case io:get_line("") of
        eof -> NewMonkeys;
        _   -> spawn_monkeys(NewMonkeys)
    end.

start() ->
    rounds:start(1, spawn_monkeys(#{})),
    init:stop().
