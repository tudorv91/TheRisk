clear
idx = 1;
%first pass
for k = 1:100
for i = 1:1000
    gamestate = generate_gamestate;
    inputVect = gamestate';
    
    [sz1,sz2]=size(inputVect);
    inputVect=reshape(inputVect,1,sz1*sz2);
    [weights, thresholds] = generate_weights;
    curr = out_MLP([21,7,3],weights, thresholds,gamestate);
    
    if checkOutput(gamestate,curr)
        pool(idx).weights = weights;
        pool(idx).thresh = thresholds;
        idx = idx + 1;
    end
end
disp(['Finished ' int2str(k) ' out of 100']);
end

% second pass
for passNo = 1:5
    idx = 1;
    for i = 1:size(pool,2)
        gamestate = generate_gamestate;
        inputVect = gamestate';
        
        [sz1,sz2]=size(inputVect);
        inputVect=reshape(inputVect,1,sz1*sz2);
        curr = out_MLP([21,7,3],pool(i).weights, pool(i).thresh,gamestate);
        
        if checkOutput(gamestate,curr)
            pool2(idx).weights = pool(i).weights;
            pool2(idx).thresh = pool(i).thresh;
            idx = idx + 1;
        end
    end
    if idx == 1
        break;
    end
    valid(passNo) = idx-1;
    pool = pool2;
    clear pool2
    disp(['Finished pass' int2str(passNo) ' out of 100']);
end

for i = 1:500

parent1_DNA = pool(randi([1 size(pool,2)], 1, 1)).weights;
parent2_DNA = pool(randi([1 size(pool,2)], 1, 1)).weights;
child_dna = evolve(parent1_DNA, parent2_DNA, 0.5, 0.5, 0.5);

thresholds = ones(1,10)*0.001;
pool2(i).weights = child_dna;
pool2(i).thresh = thresholds;
end

for passNo = 1:5
    idx = 1;
    for i = 1:size(pool,2)
        gamestate = generate_gamestate;
        inputVect = gamestate';
        
        [sz1,sz2]=size(inputVect);
        inputVect=reshape(inputVect,1,sz1*sz2);
        curr = out_MLP([21,7,3],pool(i).weights, pool(i).thresh,gamestate);
        
        if checkOutput(gamestate,curr)
            pool2(idx).weights = pool(i).weights;
            pool2(idx).thresh = pool(i).thresh;
            idx = idx + 1;
        end
    end
    if idx == 1
        break;
    end
    valid(passNo) = idx-1;
    pool = pool2;
    clear pool2
    disp(['Finished evolution pass' int2str(passNo) ' out of 5']);
end