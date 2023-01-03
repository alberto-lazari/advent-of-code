uses crt;

var
    opponent_move, player_move, aux: char;
    score, result, move_score: integer;

begin
    score := 0;

    read (opponent_move);
    read (aux);
    read (player_move);
    
    while (opponent_move >= 'A') and (opponent_move <= 'C') do
    begin
        read (aux);

        { result = -1 lose | 0 draw | 1 win }
        result := integer (player_move) - integer ('Y');

        score := score + result * 3 + 3;

        move_score := 1 + (integer (opponent_move) - integer ('A') + result + 3) mod 3;
        score := score + move_score;

        read (opponent_move);
        read (aux);
        read (player_move);
    end;

    writeln (score);
end.
