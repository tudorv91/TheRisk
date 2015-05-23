function victor = game(player1, player2, init_gs)

global noRounds viewGameDevelopment pauseTime
roundIdx = 0;

notWon = true;
player = 1;
gs = init_gs;
noMoves = 0;

while notWon && roundIdx<noRounds && ~noMoves
    if player==1
        %         disp('turn of player 1');
        intention = player1(1, gs);
        gs = processIntention(intention, gs);
        player = 2;
    else
        %         disp('turn of player 2')
        intention = player2(2, gs);
        gs = processIntention(intention, gs);
        player = 1;
    end
    if viewGameDevelopment
        visualizeConn(gs);
    end
    roundIdx = roundIdx+1;
    [notWon, victor] = whoWon(gs);
    pause(pauseTime);
end

end