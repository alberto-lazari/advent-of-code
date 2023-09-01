-module(monkey).
-export([start/1]).

inspect_items([], [_, _, _, Parent]) ->
    Parent ! no_items;

% Inspect the first item
inspect_items([Item|Rest], [N, Operation, Test, Parent]) ->
    Temp = Operation(Item),
    New = trunc(Temp / 3),
    % io:fwrite("monkey ~w inspects ~w -> ~w / 3 = ~w~n", [N, Item, Temp, New]),
    MonkeyN = Test(New),
    Parent ! {MonkeyN, New},
    inspect_items(Rest, [N, Operation, Test, Parent]).

loop(Items, Args) ->
    [N|Rest] = Args,
    receive
        inspect ->
            io:fwrite("monkey ~w have items ~w~n", [N, Items]),
            inspect_items(Items, Args),
            loop([], Args);
        Item ->
            loop(Items ++ [Item], Args)
    end.


start(Args) ->
    [N, StartingItems|Rest] = Args,
    % io:fwrite("i'm monkey ~w and have items ~w~n", [N, StartingItems]),
    loop(StartingItems, [N|Rest]).
