-module('part-1').
-export([start/0]).

-import(monkey, [start/3]).

start() ->
    spawn(monkey, start, [[0, 1], null, null]).
