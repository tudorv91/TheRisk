function [gs] = processIntention(intention,gs)
% String format should be as follows:
% intention = [player, soldiers, origin_country, dest_country];

% Example string follows:
% intention = [1 1 4 5];

% Parse the intention string and determine the outcome of the move. If a
% player moves to an already owned country. Simply move the soldiers and
% update. If a player moves to another country, he is attacking. Always
% assume the defender defends with everything. Roll a dice based on the
% soldier numbers and higher number wins. Update the state.

%% Check if intention is valid
if any(intention)==0
    disp('[processIntention] intention has zeros')
    pause(1)
    return
end

player_id = intention(1);
soldiers_moving = intention(2);
origin_country = intention(3);
dest_country = intention(4);

if gs(origin_country,3)-soldiers_moving ==0
    disp('[processIntention] moving soldiers results in leaving a country with 0 soldiers')
    pause(1)
    return
elseif gs(dest_country,3)==0
    disp('[processIntention] moving soldiers to a country with 0 soldiers')
    pause(1)
    return
end

%% Update gamestate
% Look up the owner of dest country
owner_of_dest_country = gs(dest_country,2);
% Check if this owner is the same as the player playing
if player_id == owner_of_dest_country
    % Simply move soldiers to this country
    gs(dest_country, 3) = gs(dest_country,3) + soldiers_moving;
    gs(origin_country, 3) = gs(origin_country,3) - soldiers_moving;
elseif player_id ~= owner_of_dest_country
    % Country does not belong to player playing, he is attacking
    % How many defending soldiers?
    soldiers_defending = gs(dest_country, 3);
    if (soldiers_defending == 0); disp('[processIntention] soldiers defending = 0'); end
    
    [soldiers_attacked, soldiers_defended] = rollDice(soldiers_moving,soldiers_defending);
    
    if soldiers_defended == 0
        % Attacker wins, update state
        gs(dest_country, 2) = player_id;
        gs(dest_country, 3) = soldiers_attacked;
        gs(origin_country,3) = gs(origin_country,3) - soldiers_moving;
    elseif soldiers_attacked == 0
        % Defender wins, update the state
        gs(dest_country, 3) = soldiers_defended;
        gs(origin_country, 3) = gs(origin_country, 3) - soldiers_moving;
    else
        disp('[processIntention] No army has been defeated (set to 0)')
    end
else
    disp('player_id is apparantly something weird')
end

% if any(gs(:,2) == 1) || any(gs(:,2) == 2)
%     disp('someone has won')
% end

end
