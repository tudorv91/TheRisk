function [gamestate] = processIntention(intention,gamestate)
% String format should be as follows:
% intention = [player, soldiers, origin_country, dest_country];

% Example string follows:
% intention = [1 1 4 5];

% Parse the intention string and determine the outcome of the move. If a
% player moves to an already owned country. Simply move the soldiers and
% update. If a player moves to another country, he is attacking. Always
% assume the defender defends with everything. Roll a dice based on the
% soldier numbers and higher number wins. Update the state.

player_id = intention(1);
soldiers = intention(2);
origin_country = intention(3);
dest_country = intention(4);

% Look up the owner of dest country 
owner_of_dest_country = gamestate(dest_country,2);
% Check if this owner is the same as the player playing
if player_id == owner_of_dest_country
    % Simply move soldiers to this country
    gamestate(dest_country, 3) = gamestate(dest_country,3) + soldiers;
else
    % Country does not belong to player playing, he is attacking
    % How many defending soldiers?
    soldiers_defending = gamestate(dest_country, 3);
    attacker_chance = randi([1 6 * soldiers]);
    defender_chance = randi([1 6 * soldiers_defending]);
    if attacker_chance > defender_chance
        % Attacker wins, update state
        gamestate(dest_country, 2) = player_id;
        gamestate(dest_country, 3) = soldiers;
        gamestate(origin_country,3) = gamestate(origin_country,3) - soldiers;
    else
        % Defender wins, update the state
        gamestate(origin_country, 3) = gamestate(origin_country, 3) - 1;
    end
end
end