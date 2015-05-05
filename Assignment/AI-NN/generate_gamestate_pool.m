function gamestates = generate_gamestate_pool(gamestatesNo)
gamestates = zeros(gamestatesNo, 7, 3);

parfor idx = 1:gamestatesNo
neighbours = zeros(7,7);
for sourceIdx=1:7
    for destIdx = sourceIdx:7
        if sourceIdx~=destIdx
            conn = round(rand);
            neighbours(sourceIdx, destIdx) = conn;
            neighbours(destIdx, sourceIdx) = conn;
        end
    end
end

neighbours_vector = bi2de(neighbours(7:-1:1,:)')';

gamestate = [randi([0 1], 1, 7); randi([1 21], 1, 7); neighbours_vector]';
gamestates(idx,:,:) = gamestate;
end
end