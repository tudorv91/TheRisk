function victor = game(player1, player2, init_gs)

global noRounds pauseTime viewGameDevelopment
roundIdx = 0;

notWon = true;
player = 1;
gs = init_gs;
noMoves = 0;

while notWon && roundIdx<noRounds && ~noMoves
    if player==1
        gs = turn(player1,player,gs);
        player = 2;
    else
        gs = turn(player2,player,gs);
        player = 1;
    end
    roundIdx = roundIdx+1;
    [notWon, victor] = whoWon(gs);  % Default victor = 0 & notWon = true
    if notWon == false && roundIdx == noRounds && viewGameDevelopment
        disp('[game] is a tie')        
    end
    pause(pauseTime);
end

end