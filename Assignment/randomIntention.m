function[intention] = randomIntention(player, gamestate)
% This function analyzes the gamestate and provides an intention for a move
% First, find out which countries this player owns

% intention = [player, soldiers, origin_country, dest_country];

% gamestate = [country_id, owner, number_of_soldiers, connections]
countries_owned = find(gamestate(:,2) == player);
intention = zeros(length(countries_owned), 4);
for r=1:length(countries_owned)
    % Find the connections of the r'th country
    connection = num2str(gamestate(countries_owned(r),4));
    % Find out which one of these the player doesn't own
    % find(gamestate(str2num(connection), 2 ~= player))
    % Predefine targets and owners
    targets = zeros(1, length(connection));
    owners = zeros(1, length(connection));
    for i=1:length(connection)
        % Make vector of targets
        targets(i) = str2num(connection(i));
        % List the owners of these targets
        owners(i) = gamestate(targets(i),2);
    end
    % Indices of targets where owner is not current player
    attacktargets = find(owners ~= player);
    if length(attacktargets) >= 1
        target_selector = randi([1 length(attacktargets)]);
        attacktarget = targets(target_selector);
        %target = str2num(target);
        if gamestate(countries_owned(r), 3) > 1
            intention(r,:) = [player, gamestate(countries_owned(r), 3) - 1, countries_owned(r), attacktarget];    
        end
        intention(~any(intention,2),:) =[];
    end
end
% Now there exists an array of  options, pick one
random_action_selector = randi([1 size(intention,1)]);
intention = intention(random_action_selector,:);
end
