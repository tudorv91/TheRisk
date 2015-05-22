function [possibleMoves] = findPossibleMoves(myID,gamestate)
% Determine the possible moves that can be made. This includes that no
% moves can be made from a country with only 1 army
% possibleMoves = [myCountry targetCountry myArmy targetArmy targetOwner]

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

% disp('[findPossibleMoves] Table with possible targets')
% disp(array2table(targets,'VariableNames',{'myCountry' 'Target' 'myArmy' 'targetArmy' 'targetOwner'}))

possibleMoves = targets(targets(:,3)~= 1,:); % countries with 1 army cannot attack
if isempty(possibleMoves)
    possibleMoves = [0 0 0 0 0]
end
end