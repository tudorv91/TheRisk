function intention = probablisticIntention(player, gamestate)

%countries_owned = find(gamestate(:,2) == player);
%intention = zeros(length(countries_owned), 4);
%for r=1:length(countries_owned)
    % Find the connections of the r'th country
%    connection = num2str(gamestate(countries_owned(r),4));
    % Find out which one of these the player doesn't own
    % find(gamestate(str2num(connection), 2 ~= player))
    % Predefine targets and owners
 %   targets = zeros(1, length(connection));
 %   owners = zeros(1, length(connection));
 %   for i=1:length(connection)
        % Make vector of targets
 %       targets(i) = str2num(connection(i));
        % List the owners of these targets
 %       owners(i) = gamestate(targets(i),2);
 %   end
    % Indices of targets where owner is not current player
 %   attacktargets = find(owners ~= player);
 %   if length(attacktargets) >= 1
 %       target_selector = randi([1 length(attacktargets)]);
 %       attacktarget = targets(target_selector);
        %target = str2num(target);
 %       if gamestate(countries_owned(r), 3) > 1
 %           intention(r,:) = [player, gamestate(countries_owned(r), 3) - 1, countries_owned(r), attacktarget];    
 %       end
 %       intention(~any(intention,2),:) =[];
 %   end
%end
possible_moves = findPossibleMoves(player, gamestate);
if any(possible_moves)==0
    intention = [0 0 0 0]
    return
end

%%
% Now we have a list of intentions, our AI should analyse these to find the
% one with the best chance of succes. It does this by a 'simulation' of the
% intention processing.
probability = zeros(size(possible_moves,1),1);
for i = 1:size(possible_moves,1)
    % Process this intention 10 times, see how many of the battles were 
    % and make a percentage of this.
    % processIntention(intenion(i), gamestate)
    % if(gamestate(targetcountry == player country)) meaning we won
    % then this is a victory, else this is a loss.
    % Repeat 10 times
    % calculate win probability and add this to the intention vector
    player_id = possible_moves(i,5);
    soldiers_att = possible_moves(i,3) - 1;
    soldiers_def = possible_moves(i,4);
    origin_country = possible_moves(i,1);
    dest_country = possible_moves(i,2);

    % Look up the owner of dest country 
    owner_of_dest_country = gamestate(dest_country,2);
    % Check if this owner is the same as the player playing
    if player == owner_of_dest_country
        % Simply move soldiers to this country
        %gamestate(dest_country, 3) = gamestate(dest_country,3) + soldiers;
    else
        % Country does not belong to player playing, he is attacking
        % How many defending soldiers?
        amountofwins    = 0;
        trials          = 10;
        for j = 1:trials
            attacker_chance = randi([1 6 * soldiers_att]);
            defender_chance = randi([1 6 * soldiers_def]);
            if attacker_chance > defender_chance
                % Attacker wins, update state
                amountofwins = amountofwins + 1;
            else
                % Defender wins, update the state
            end
        end
        probability(i) = amountofwins / trials * 100;
    end
end

% Pick the highest probability intention
possible_moves = possible_moves(probability == max(probability),:);

if size(possible_moves,1) >= 2
    possible_moves = possible_moves(randi(size(possible_moves,1)),:);
end

intention = [player possible_moves(3)-1 possible_moves(1) possible_moves(2)];
%end