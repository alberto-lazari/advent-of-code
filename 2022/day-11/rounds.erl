-module(rounds).
-export([start/3]).

redirect_throws(Monkeys) ->
    receive
        {Receiver, Item} ->
            % io:fwrite("monkey ~w received ~w~n", [Receiver, Item]),
            maps:get(Receiver, Monkeys) ! Item,
            redirect_throws(Monkeys);
        no_items ->
            done
    end.

start(N, _, Rounds) when N > Rounds ->
    stop;

start(N, Monkeys, Rounds) ->
    % io:fwrite("~nRound ~w:~n", [N]),
    maps:map(fun(_, Pid) ->
                     Pid ! inspect,
                     redirect_throws(Monkeys)
             end,
             Monkeys
     ),
    start(N + 1, Monkeys, Rounds).
