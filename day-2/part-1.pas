uses crt;

var
    opponent_move, player_move, aux: char;
    score: integer;

begin
    score := 0;

    read(opponent_move);
    read(aux);
    read(player_move);
    
    while opponent_move <> slinebreak do
    begin
        read(aux);

        case opponent_move of
            'A' : score := score + 8;
            'B' : score := score + 1;
            'C' : score := score + 6;
        end;

        read(opponent_move);
        read(aux);
        read(player_move);
        writeln(opponent_move, player_move);
    end;

    writeln(score);
end.

