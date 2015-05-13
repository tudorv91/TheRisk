function[intention] = customAIintention(myID, gamestate)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function analyzes the gamestate and provides an intention for a move
% First, find out which countries this player owns
%
% intention = [player, soldiers, origin_country, dest_country];
% gamestate = [country_id, owner, number_of_soldiers, connections]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For debugging and design purposes, to be uncommented:
% close all
% clear
% clc
% gamestate = init();
% visualizeConn(gamestate);
% myID = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Determine the possible movements 
possibleMoves = findPossibleMoves(myID,gamestate);

%% Determine the best move
for i = 1:length(possibleMoves)
    
end

%% Set intention as output
player          = myID;
soldiers        = 42;
origin_country  = 42;
dest_country    = 42;

intention   = [player, soldiers, origin_country, dest_country];

end
