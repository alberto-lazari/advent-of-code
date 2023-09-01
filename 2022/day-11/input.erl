-module(input).
-export([starting_items/0, operation_fun/0, test_fun/0]).

% Superior highly composite number (https://oeis.org/A002201)
-define(GCD, 6064949221531200).

% As long as there are commas there are elements to read
read_items({ok, [","]}, Items) ->
    {ok, [Item]} = io:fread("", "~d"),
    read_items(io:fread("", "~s"), Items ++ [Item]);

read_items(_, Items) -> Items.

% Creates the list of the starting items
starting_items() ->
    {ok, [Item]} = io:fread("", "  Starting items: ~d"),
    read_items(io:fread("", "~s"), [Item]).

% Creates the operation function
operation_fun() ->
    {ok, [Op]} = io:fread("", " new = old ~c"),
    {ok, [Val]} = io:fread("", "~s"),
    fun(Old) ->
            Value = case Val of
                        "old" -> Old;
                        _     -> list_to_integer(Val)
                    end,

            case Op of
                "+" -> Old + Value;
                "*" -> Old * Value
            end rem ?GCD
    end.

% Creates the test function, that returns the monkey to throw the item to
test_fun() ->
    {ok, [ToTest]} = io:fread("", "  Test: divisible by ~d"),
    {ok, [TrueMonkey]} = io:fread("", "    If true: throw to monkey ~d"),
    {ok, [FalseMonkey]} = io:fread("", "    If false: throw to monkey ~d"),
    fun(WorryLevel) ->
            case WorryLevel rem ToTest of
                0 -> TrueMonkey;
                _ -> FalseMonkey
            end
    end.
