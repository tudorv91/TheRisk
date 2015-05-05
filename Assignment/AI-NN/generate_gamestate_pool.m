function gamestates = generate_gamestate_pool(gamestatesNo)
noCountries = 7;

% The gamestate matrix will have two columns for country ownership and and
% troops available and another (noCountries-1) columns for neighbours.
gamestates = int8(zeros(gamestatesNo, noCountries, 2+noCountries));

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
    
    gamestate = [randi([0 1], 1, 7); randi([1 21], 1, 7); neighbours]';
    gamestates(idx,:,:) = gamestate;
end
end
