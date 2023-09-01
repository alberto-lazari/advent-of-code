-module('part-2').
-export([start/0]).

-import(input, [starting_items/0, operation_fun/0, test_fun/0]).

spawn_monkeys(Monkeys, Self, Counter) ->
    {ok, [N]} = io:fread("", "Monkey ~d:"),
    Pid = spawn(
            monkey,
            start,
            [ [N, starting_items(), operation_fun(), {divide, false}, test_fun(), Self, Counter] ]
           ),
    NewMonkeys = maps:put(N, Pid, Monkeys),

    case io:get_line("") of
        eof -> NewMonkeys;
        _   -> spawn_monkeys(NewMonkeys, Self, Counter)
    end.

start() ->
    Self = erlang:self(),
    Counter = spawn(counter, start, [Self]),
    Monkeys = spawn_monkeys(#{}, Self, Counter),
    rounds:start(1, Monkeys, 10000),

    Counter ! get,
    receive
        Inspections ->
            Values = maps:values(Inspections),
            % io:fwrite("~w~n", [Values]),
            Max = lists:max(Values),
            SecondMax = lists:max(lists:delete(Max, Values)),
            io:fwrite("~w~n", [Max * SecondMax])
    end,

    init:stop().
