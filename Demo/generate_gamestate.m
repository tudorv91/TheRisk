function gamestate = generate_gamestate
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

gamestate = [randi([0 1], 1, 7); randi([1 7], 1, 7); neighbours_vector]';
end