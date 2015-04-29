function [gamestate] = init()
% Gamestate is given as a matrix where the rows are each the situation of
% the country. The columns give the attributes of the countries.

% gamestate = [country_id, owner, number_of_soldiers, connections]
% owner 0: Neutral country, has 1 soldier in each country
% owner 1: Player 1 owns this country, starts with 3 soldiers
% owner 2: Player 2 owns this country, starts with 3 soldiers
gamestate =     [1 1 1 2367;
    2 1 5 13;
    3 0 1 1624;
    4 1 3 563;
    5 0 1 46;
    6 2 1 3541;
    7 2 3 1;
    ];

end