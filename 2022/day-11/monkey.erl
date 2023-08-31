-module(monkey).
-export([start/3]).

start([First | Rest], Operation, Test) ->
    io:format("Item: ~B", First).
