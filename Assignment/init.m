function [gamestate] = init()
% Gamestate is given as a matrix where the rows are each the situation of
% the country. The columns give the attributes of the countries.

% gamestate = [country_id, owner, number_of_soldiers, connections]
% owner 0: Neutral country, has 1 soldier in each country
% owner 1: Player 1 owns this country, starts with 3 soldiers
% owner 2: Player 2 owns this country, starts with 3 soldiers
gamestate =     [1 0 1 235;
                 2 0 1 167;
                 3 0 1 16;
                 4 1 3 5;
                 5 0 1 14; 
                 6 0 1 23;
                 7 2 3 2;
                ];
end