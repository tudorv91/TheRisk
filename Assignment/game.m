clc
close all
clear
format compact

% Initialise the game
gamestate = init();
disp(gamestate);
visualizeConn(gamestate);

% Amount of moves
moves = 10;

% Preallocate statistics 
ID_customAI = 2;
ID_randomAI = 1;
player1_countries = zeros(1,moves);
player2_countries = zeros(1,moves);
player1_army = zeros(1,moves);
player2_army = zeros(1,moves);

% Gather stats
player1_countries(1) = numel(gamestate(find(gamestate(:,2) == 1)));
player2_countries(1) = numel(gamestate(find(gamestate(:,2) == 2)));
player1_army(1) = sum(gamestate(find(gamestate(:,2) == 1), 3));
player2_army(1) = sum(gamestate(find(gamestate(:,2) == 2), 3));

player_at_turn = 1;
j = 1;
for i = 2:moves+1
    
    player = player_at_turn;
    % Make a move
    
%     if player == ID_customAI % Take intention from player
%         intention = customAIintention(player,gamestate);
%     elseif player == ID_randomAI
        intention = randomIntention(player,gamestate);
%     end
    gamestate = processIntention(intention, gamestate);
    disp('intention & gamestate')
    disp(intention);
    disp(gamestate);
    
    % Gather stats
    player1_countries(i) = numel(gamestate(find(gamestate(:,2) == 1)));
    player2_countries(i) = numel(gamestate(find(gamestate(:,2) == 2)));
    player1_army(i) = sum(gamestate(find(gamestate(:,2) == 1), 3));
    player2_army(i) = sum(gamestate(find(gamestate(:,2) == 2), 3));
    
    % alternate between players
    if player_at_turn == 1
        player_at_turn = 2;
    else
        player_at_turn = 1;
    end
    j = j+1;
    if j == 2
        gamestate(find(gamestate(:,2)~=0),3) = gamestate(find(gamestate(:,2)~=0),3) + 1;
        j = 1;
    end
end

move = 0:1:moves;
figure; plot(move, player1_countries, move, player2_countries);
