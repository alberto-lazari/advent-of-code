-module(counter).
-export([start/1]).

count(Inspections, Parent) ->
    receive
        get -> Parent ! Inspections;
        N -> case maps:is_key(N, Inspections) of
                 true -> count(
                           maps:update_with(N, fun(Old) -> Old + 1 end, Inspections),
                           Parent
                          );
                 false -> count(maps:put(N, 1, Inspections), Parent)
             end
    end.

start(Parent) ->
    count(#{}, Parent).
