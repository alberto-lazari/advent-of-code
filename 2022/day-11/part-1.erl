-module('part-1').
-export([start/0]).

read_items({ok, [","]}, Items) ->
    {ok, [Item]} = io:fread("", "~d"),
    read_items(io:fread("", "~s"), Items ++ [Item]);

read_items(_, Items) -> Items.

spawn_monkeys() ->
    {ok, [N]} = io:fread("", "Monkey ~d:"),
    {ok, [Item]} = io:fread("", "  Starting items: ~d"),
    StartingItems = read_items(io:fread("", "~s"), [Item]),

    {ok, [Op]} = io:fread("", " new = old ~c"),
    {ok, [Val]} = io:fread("", "~s"),
    Operation = fun(Old) ->
                        Value = case Val of
                                  "old" -> Old;
                                  _     -> list_to_integer(Val)
                              end,
                        case Op of
                            "+" -> Old + Value;
                            "*" -> Old * Value
                        end
                end,
    {ok, [ToTest]} = io:fread("", "  Test: divisible by ~d"),
    {ok, [TrueMonkey]} = io:fread("", "    If true: throw to monkey ~d"),
    {ok, [FalseMonkey]} = io:fread("", "    If false: throw to monkey ~d"),
    Test = fun(WorryLevel) -> case WorryLevel rem ToTest of
                                  0 -> TrueMonkey;
                                  _ -> FalseMonkey
                              end
           end,

    spawn(monkey, start, [N, StartingItems, Operation, Test]),

    case io:get_line("") of
        eof -> N + 1;
        _ -> spawn_monkeys()
    end.

start() ->
    spawn_monkeys().
