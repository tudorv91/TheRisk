function [gamestate, connCountries] = init()
% Gamestate is given as a matrix where the rows are each the situation of
% the country. The columns give the attributes of the countries.

% gamestate = [country_id, owner, number_of_soldiers, connections]
% owner 0: Neutral country, has 1 soldier in each country
% owner 1: Player 1 owns this country, starts with 3 soldiers
% owner 2: Player 2 owns this country, starts with 3 soldiers
gamestate =     [1 0 2 24679;
    2 1 30 139;
    3 0 3 6249;
    4 0 3 1539;
    5 2 30 469;
    6 0 2 35179;
    7 0 3 169;
    8 0 3 2379
    9 0 2 12345678];

connCountries = [0 1 0 1 0 1 1 0 1;
 1 0 1 0 0 0 0 1 1;
 0 1 0 1 0 1 0 1 1;
 1 0 1 0 1 0 0 0 1;
 0 0 0 1 0 1 0 0 1;
 1 0 1 0 1 0 1 0 1;
 1 0 0 0 0 1 0 1 1;
 0 1 1 0 0 0 1 0 1;
 1 1 1 1 1 1 1 1 0
 ];

%visualizeConn(gamestate)

end