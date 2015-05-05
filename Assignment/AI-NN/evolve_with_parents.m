function evolve_with_parents(pool, gamestates, new_fit)

mutation_rate = 0.5;
figure;
noGamestates = size(gamestates,1);

% Remember the selection size as we will change the pool, by always keeping
% the upper half of the most fitted chromosomes
selection_size = size(pool,2);

[~, indexes] = sort(new_fit);
pool = pool(indexes(round(selection_size/2):end));

for tr_sessions = 1:1000
    idx = 1;
    while idx < selection_size
        firstIdx = randi([1 size(pool,2)], 1, 1);
        secondIdx = randi([1 size(pool,2)], 1, 1);
        [offspring_1, offspring_2] = evolve_crossover(pool(firstIdx),pool(secondIdx),mutation_rate);
        
        % Check and compute the offspring's fitness
        for gStateIdx = 1:noGamestates
            gamestate = squeeze(gamestates(gStateIdx,:,:));
            off1_out = out_MLP([21,7,3], offspring_1, gamestate);
            off2_out = out_MLP([21,7,3], offspring_2, gamestate);
            if checkOutput(gamestate, off1_out)
                offspring_1.fitness = offspring_1.fitness+1;
            end
            if checkOutput(gamestate, off2_out)
                offspring_2.fitness = offspring_2.fitness+1;
            end
        end
        
        offspring_1.fitness = offspring_1.fitness/noGamestates;
        offspring_2.fitness = offspring_2.fitness/noGamestates;
        
        new_pool(idx) = offspring_1;
        new_fit(idx) = offspring_1.fitness;
        
        idx = idx + 1;
       
        new_pool(idx) = offspring_2;
        new_fit(idx) = offspring_2.fitness;
    end
    meanVect(tr_sessions) = mean(new_fit);
    maxVect(tr_sessions) = max(new_fit);
    
    subplot(211),plot(1:size(meanVect,2),meanVect,'-b',1:size(meanVect,2),maxVect,'-r');
    subplot(212),hist(new_fit,0:0.1:1);
    drawnow;
    
    pool = new_pool;
    [~, indexes] = sort(new_fit);
    pool = pool(indexes(round(end/2):end));
    new_fit = 0;
end