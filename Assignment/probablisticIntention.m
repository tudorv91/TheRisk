function intention = probablisticIntention(player, gamestate)
    possible_moves = findPossibleMoves(player, gamestate);
    
    if any(possible_moves)==0
        disp('[probIntent] no possible moves ==> intention = []')
    %     possible_moves
        intention = [];
    %     intention = [0 0 0 0]
        return
    end

    %%
    % Now we have a list of intentions, our AI should analyse these to find the
    % one with the best chance of succes. It does this by a 'simulation' of the
    % intention processing.
    probability = zeros(size(possible_moves,1),1);
    average_invaders = zeros(size(possible_moves,1),1);
    surroundingEnemyArmy = zeros(size(possible_moves,1),1);
    for i = 1:size(possible_moves,1)
        % Find connected countries of target
        connectedCountries = num2str(gamestate(possible_moves(i,2),4));
        %for each of these connected countries, sum the total amount of
        %enemy soldiers surrounding it
        for l = 1:length(connectedCountries)
            if gamestate(str2num(connectedCountries(l)),2) ~= player
                surroundingEnemyArmy(i) = surroundingEnemyArmy(i) + gamestate(str2num(connectedCountries(l)),3);
            end
        end
        
        % Process this intention j times, see how many of the battles were 
        % and make a percentage of this.

        player_id = possible_moves(i,5);
        soldiers_att = possible_moves(i,3) - 1;
        soldiers_def = possible_moves(i,4);
        origin_country = possible_moves(i,1);
        dest_country = possible_moves(i,2);

        % Look up the owner of dest country 
        owner_of_dest_country = gamestate(dest_country,2);
        % Check if this owner is the same as the player playing
        if player == owner_of_dest_country
            % If player is owner of target, he can just reinforce this
            % country if all other options are worse than a 50/50 chance of
            % success
            probability(i) = 50;
            %average_invaders(i) = soldiers_def + soldiers_att;
            % Simply move soldiers to this country
            %gamestate(dest_country, 3) = gamestate(dest_country,3) + soldiers;
        else
            % Country does not belong to player playing, he is attacking
            % How many defending soldiers?
            amountofwins    = 0;
            trials          = 500;
            
            %average army remaining to take next country
            for j = 1:trials
                [att_remaining, def_remaining] = rollDice2Death(soldiers_att, soldiers_def);
                attacker_chance = randi([1 6 * soldiers_att]);
                defender_chance = randi([1 6 * soldiers_def]);
                if att_remaining > def_remaining
                    % Attacker wins, update state
                    amountofwins = amountofwins + 1;
                    average_invaders(i) = average_invaders(i) + att_remaining;
                end
            end
            average_invaders(i) = average_invaders(i) / trials;
            
            probability(i) = amountofwins / trials * 100;
        end      
    end
    %disp(probability); % P(we take it) (except for countries already belonging to player
    %disp(average_invaders);
    %disp(surroundingEnemyArmy);
    
    % Let surrounding enemy army also play a role
    % multiply probabilities with a factor. * 1.0 for the lowest amount of
    % enemies, *0.5 for the highest amount of enemies and linearise in
    % between.
    SRA = surroundingEnemyArmy;
    highestSurroundingEnemyArmy = SRA(find(SRA == max(SRA))); % 0.5
    lowestSurroundingEnemyArmy = SRA(find(SRA == min(SRA))); % 1.0
    a = (0.5 - 1) / (highestSurroundingEnemyArmy - lowestSurroundingEnemyArmy);
    b = 1.0 - a * lowestSurroundingEnemyArmy;
    factors = a * SRA + b;
    %disp(factors);
    %disp(probability .* factors);
    probability = probability .* factors; %this lets the AI take the safest route
    
    % Pick the highest probability intention
    possible_moves = possible_moves(probability == max(probability),:);

    if size(possible_moves,1) >= 2
        possible_moves = possible_moves(randi(size(possible_moves,1)),:);
    end

    intention = [player possible_moves(3)-1 possible_moves(1) possible_moves(2)];
end