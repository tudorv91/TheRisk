% function[intention] = customAIintention(myID, gamestate)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function analyzes the gamestate and provides an intention for a move
% First, find out which countries this player owns
%
% intention = [player, soldiers, origin_country, dest_country];
% gamestate = [country_id, owner, number_of_soldiers, connections]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For debugging and design purposes, to be uncommented:
close all
clear
clc
gamestate = init();
visualizeConn(gamestate);
myID = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Determine the countries owned by this AI
myCountries = gamestate(gamestate(:,2)==myID,1);

%% Determine the possible movements 
nTargets = 0;
for i = 1:length(myCountries)
    connectedCountries = num2str(gamestate(myCountries(i),4));
    nTargets = nTargets + length(connectedCountries);
end

targets = zeros(nTargets,5);
k = 0;

for i = 1:length(myCountries)
    connectedCountries = num2str(gamestate(myCountries(i),4));
    for j = 1:length(connectedCountries)
        k = k + 1;
        connectedCountry = str2double(connectedCountries(j));
        targets(k,:) = [ myCountries(i) connectedCountry ...
            gamestate(myCountries(i),3) gamestate(connectedCountry,3) ...
            gamestate(connectedCountry,2)];
    end
end 

disp('Table with possible targets')
disp(array2table(targets,'VariableNames',{'myCountry' 'Target' 'myArmy' 'targetArmy' 'targetOwner'}))

%% Determine best move

possibleMoves = targets(targets(:,3)~= 1,:) % countries with 1 army cannot attack

for i = 1:length(possibleMoves)
    
end

player          = myID;
soldiers        = 42;
origin_country  = 42;
dest_country    = 42;

intention   = [player, soldiers, origin_country, dest_country];


%% Old code
% countries_owned = find(gamestate(:,2) == player);
% intention = zeros(length(countries_owned), 4);
% for r=1:length(countries_owned)
%     % Find the connections of the r'th country
%     connection = num2str(gamestate(countries_owned(r),4));
%     % Find out which one of these the player doesn't own
%     % find(gamestate(str2num(connection), 2 ~= player))
%     % Predefine targets and owners
%     targets = zeros(1, length(connection));
%     targets_owners = zeros(1, length(connection));
%     for i=1:length(connection)
%         % Make vector of targets
%         targets(i) = str2double(connection(i));
%         % List the owners of these targets
%         targets_owners(i) = gamestate(targets(i),2);
%     end
%     % Indices of targets where owner is not current player
%     attacktargets = find(targets_owners ~= player);
%     if length(attacktargets) >= 1
%         target_selector = randi([1 length(attacktargets)]);
%         attacktarget = targets(target_selector);
%         %target = str2num(target);
%         if gamestate(countries_owned(r), 3) > 1
%             intention(r,:) = [player, gamestate(countries_owned(r), 3) - 1, countries_owned(r), attacktarget];    
%         end
%         intention(~any(intention,2),:) =[];
%     end
% end
% % Now there exists an array of  options, pick one
% random_action_selector = randi([1 size(intention,1)]);
% intention = intention(random_action_selector,:);
% end
