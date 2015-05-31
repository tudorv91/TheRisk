function result = playWithMap(player_handle)

global noRounds pauseTime
roundIdx = 0;
conquered = 0;

gs = init();

while ~conquered && roundIdx<noRounds
    gs = turn(player_handle, 1, gs);
    roundIdx = roundIdx+1;
    if numel(find(gs(:,2)==1))==7
        break;
    end
    if roundIdx == noRounds
%         disp('[game] is a tie')
        roundIdx = 0;
        break;
    end
    pause(pauseTime);
end
result = roundIdx;
end