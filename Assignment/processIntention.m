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
soldiers_moving = intention(2);
origin_country = intention(3);
dest_country = intention(4);

% Look up the owner of dest country
owner_of_dest_country = gamestate(dest_country,2);
% Check if this owner is the same as the player playing
if player_id == owner_of_dest_country
    % Simply move soldiers to this country
    gamestate(dest_country, 3) = gamestate(dest_country,3) + soldiers_moving;
else
    % Country does not belong to player playing, he is attacking
    % How many defending soldiers?
    soldiers_defending = gamestate(dest_country, 3);
    
    [soldiers_attacked, soldiers_defended] = rollDice(soldiers_moving,soldiers_defending);
    
    if soldiers_defended == 0
        % Attacker wins, update state
        gamestate(dest_country, 2) = player_id;
        gamestate(dest_country, 3) = soldiers_attacked;
        gamestate(origin_country,3) = gamestate(origin_country,3) - soldiers_moving;
    elseif soldiers_attacked == 0
        % Defender wins, update the state
        gamestate(dest_country, 3) = soldiers_defended;
        gamestate(origin_country, 3) = gamestate(origin_country, 3) - soldiers_moving;
    else
        disp('[processIntention] No army has been defeated (set to 0)')
    end
end
end