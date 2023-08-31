-module(monkey).
-export([start/4]).

start(N, StartingItems, Operation, Test) ->
    io:fwrite("i'm monke ~w and have items ~w~n", [N, StartingItems]).
