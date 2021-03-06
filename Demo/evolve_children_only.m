function evolve_children_only(pool,gamestates)
new_fit = 0;
figure;
for tr_sessions = 1:100000
    for idx = 1:size(pool,2)
        firstIdx = randi([1 size(pool,2)], 1, 1);
        secondIdx = randi([1 size(pool,2)], 1, 1);
        child_dna = evolve(pool(firstIdx),pool(secondIdx),0.3);
        child_dna.fitness = 0;
        
        for gStateIdx = 1:size(gamestates,1)
            gamestate = squeeze(gamestates(gStateIdx,:,:));
            curr = out_MLP([21,7,3],child_dna.weightsH, child_dna.weightsOut, ...
                child_dna.thresh, child_dna.multipliers, gamestate);
            
            if checkOutput(gamestate,curr)
                child_dna.fitness = child_dna.fitness+1;
            end
        end
        new_pool(idx) = child_dna;
        new_fit(idx) = child_dna.fitness;
    end
    meanVect(tr_sessions) = mean(new_fit);
    maxVect(tr_sessions) = max(new_fit);
    subplot(211),plot(1:size(meanVect,2),meanVect,'-b',1:size(meanVect,2),maxVect,'-r');
    subplot(212),hist(new_fit);
    drawnow;
    new_fit = zeros(size(pool,2),1);
    pool = new_pool;
end