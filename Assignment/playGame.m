function[scorePlayer1, scorePlayer2] = playGame(player1_process, player2_process)
scorePlayer1 = 0; scorePlayer2 = 0;
% Both games should have the same gamestate
gamestate = init();
% we have 2 players, we need to let them play 2 games
% players  are just systems that output  intentions
victorGame1 = game(player1_process, player2_process, gamestate); % this should output a victor
% let game just always let player 1 start, and we want now a second game
% where player 2 starts,
victorGame2 = game(player2_process, player1_process, gamestate);

if victorGame1 == 1
    scorePlayer1 = scorePlayer1 + 3;
elseif victorGame1 == 2
    scorePlayer2 = scorePlayer2 + 3;
else
    scorePlayer1 = scorePlayer1 + 1;
    scorePlayer2 = scorePlayer2 + 1;
end

if victorGame2 == 1
    scorePlayer2 = scorePlayer2 + 3;
elseif victorGame2 == 2
    scorePlayer1 = scorePlayer1 + 3;
else
    scorePlayer1 = scorePlayer1 + 1;
    scorePlayer2 = scorePlayer2 + 1;
end