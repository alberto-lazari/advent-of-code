-module(monkey).
-export([start/1]).

inspect_items([], [_, _, _, _, Parent, _]) ->
    Parent ! no_items;

% Inspect the first item
inspect_items([Item|Rest], Args) ->
    [N, Operation, {divide, Divide}, Test, Parent, Counter] = Args,
    New = Operation(Item),
    NewDivided = trunc(New / 3),
    ToSend = case Divide of
                 true -> NewDivided;
                 false -> New
             end,
    % io:fwrite("monkey ~w inspects ~w -> ~w / 3 = ~w~n", [N, Item, New, NewDivided]),
    MonkeyN = Test(ToSend),
    % Keep trace of the inspection
    Counter ! N,
    Parent ! {MonkeyN, ToSend},
    inspect_items(Rest, Args).

loop(Items, Args) ->
    [N|_] = Args,
    receive
        inspect ->
            % io:fwrite("monkey ~w have items ~w~n", [N, Items]),
            inspect_items(Items, Args),
            loop([], Args);
        Item ->
            loop(Items ++ [Item], Args)
    end.


start(Args) ->
    [N, StartingItems|Rest] = Args,
    % io:fwrite("i'm monkey ~w and have items ~w~n", [N, StartingItems]),
    loop(StartingItems, [N|Rest]).
