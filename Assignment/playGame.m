function[scorePlayer1, scorePlayer2] = playGame(player1, player2)
%player1/player2 is a string format "probabilistic" or "random" or
%"NN"

scorePlayer1 = 0; scorePlayer2 = 0;
% Both games should have the same gamestate
gamestate = init();
% we have 2 players, we need to let them play 2 games
% players  are just systems that output  intentions
victorGame1 = game(player1, player2, gamestate); % this should output a victor
% let game just always let player 1 start, and we want now a second game
% where player 2 starts,
victorGame2 = game(player2, player1, gamestate);

if victorGame1 == player1
    scorePlayer1 = scorePlayer1 + 3;
elseif victorGame1 == player2
    scorePlayer2 = scorePlayer2 + 3;
else
    scorePlayer1 = scorePlayer1 + 1;
    scorePlayer2 = scorePlayer1 + 1;
end

if victorGame2 == player1
    scorePlayer1 = scorePlayer1 + 3;
elseif victorGame1 == player2
    scorePlayer2 = scorePlayer2 + 3;
else
    scorePlayer1 = scorePlayer1 + 1;
    scorePlayer2 = scorePlayer1 + 1;
        
end