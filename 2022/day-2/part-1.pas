uses crt;

var
    opponent_move, player_move, aux: char;
    score: integer;

function result (opponent_move, player_move: char): integer;
(*
    Returns:
    1 if player wins
    0 if there's a draw
    -1 if opponent wins
*)
var
    o, p : integer;

begin
    o := integer (opponent_move) - integer ('A');
    p := integer (player_move) - integer ('X');

    result := (p - o + 3) mod 3;
    if result = 2 then result := -1;
end;

begin
    score := 0;

    read (opponent_move);
    read (aux);
    read (player_move);
    
    while (opponent_move >= 'A') and (opponent_move <= 'C') do
    begin
        read (aux);

        score := score + result (opponent_move, player_move) * 3 + 3;
        score := score + 1 + integer (player_move) - integer ('X');

        read (opponent_move);
        read (aux);
        read (player_move);
    end;

    writeln (score);
end.

