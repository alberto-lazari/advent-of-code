-module(rounds).
-export([start/2]).

-define(ROUNDS, 20).

redirect_throws(Monkeys) ->
    receive
        {Receiver, Item} ->
            % io:fwrite("monkey ~w received ~w~n", [Receiver, Item]),
            maps:get(Receiver, Monkeys) ! Item,
            redirect_throws(Monkeys);
        no_items ->
            done
    end.

start(N, _) when N > ?ROUNDS ->
    stop;

start(Round, Monkeys) ->
    io:fwrite("~nRound ~w:~n", [Round]),
    maps:map(fun(N, Pid) ->
                     Pid ! inspect,
                     redirect_throws(Monkeys)
             end,
             Monkeys
     ),
    start(Round + 1, Monkeys).
