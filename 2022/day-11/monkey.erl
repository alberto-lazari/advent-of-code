-module(monkey).
-export([start/4]).

start(N, StartingItems, Operation, Test) ->
    io:fwrite("i'm monke ~w~n", [N]).
