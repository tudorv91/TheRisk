function [notWon, victor] = whoWon(gamestate)
% If one player completely dominated the other player, this function
% returns who is the winner and switches notWon to false (someone won)

if numel(find(gamestate(:,2)==1))==0
    victor = 2;
    notWon = false;
    disp('[whoWon] = player 2')
elseif numel(find(gamestate(:,2)==2))==0
    victor = 1;
    notWon = false;
    disp('[whoWon] = player 1')
else
    victor = 0;
    notWon = true;
end