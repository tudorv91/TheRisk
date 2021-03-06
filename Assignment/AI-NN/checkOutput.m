function correct = checkOutput(gamestate, output)

outTroops = output(1);
origin = output(2);
dest = output(3);

troops_mobility = sum(gamestate(find(gamestate(:,1)==1),2)-1);
if troops_mobility < outTroops || outTroops<1
    correct = 0;
    return
end

if (origin > 7 || origin < 1) || (dest > 7 || dest < 1)
    correct = 0;
    return
end

if any(gamestate(find(gamestate(:,1)==1),dest+2))
    correct = gamestate(origin,1);
else
    correct = 0;
end
end
