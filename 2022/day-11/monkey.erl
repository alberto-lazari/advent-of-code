-module(monkey).
-export([start/4]).

% Inspect the first item (if any)
inspect_items(N, Items, Operation, Test) ->
    case Items of
        []          -> no_items;
        [Item|Rest] ->
            Temp = Operation(Item),
            New = round(Temp / 3),
            io:fwrite("monkey ~w inspects ~w -> ~w / 3 = ~w~n", [N, Item, Temp, New]),
            inspect_items(N, Rest, Operation, Test)
    end.

start(N, StartingItems, Operation, Test) ->
    io:fwrite("i'm monkey ~w and have items ~w~n", [N, StartingItems]),
    receive
        inspect -> inspect_items(N, StartingItems, Operation, Test)
    end.
