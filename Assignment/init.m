function [gamestate] = init()
% Gamestate is given as a matrix where the rows are each the situation of
% the country. The columns give the attributes of the countries.

% gamestate = [country_id, owner, number_of_soldiers, connections]
% owner 0: Neutral country, has 1 soldier in each country
% owner 1: Player 1 owns this country, starts with 3 soldiers
% owner 2: Player 2 owns this country, starts with 3 soldiers
gamestate =     [1 0 2 2467;
    2 1 30 13;
    3 0 3 624;
    4 0 3 153;
    5 2 30 46;
    6 0 2 3517;
    7 0 3 16;
    ];
% visualizeConn(gamestate)

end