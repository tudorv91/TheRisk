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

neighbours = de2bi(gamestate(find(gamestate(:,1)==1),3),7);
ne = sum(neighbours);

if numel(ne)==1
    correct = 0;
    return
end

if ne(dest)== 0
    correct = 0;
    return
end

correct = gamestate(origin,1);
end
