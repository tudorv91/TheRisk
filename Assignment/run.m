format compact
clc
clear
close all
addpath('./AI-NN')

%% Setup program
% % Section used for globals (avoid transmitting all parameters as arguments)
% % All initial game conditions should be specified here (session setup)
global nnStruct chromosome chromosome2 noRounds viewGameDevelopment pauseTime nIncome poolSize mutation_rate

viewGameDevelopment = 0;
nnStruct = [3 10 1];
chromosome = gen_chromosome(nnStruct);
chromosome2 = gen_chromosome(nnStruct);
noRounds = 100;
pauseTime = 0;
nIncome = 2;
poolSize = 50;
mutation_rate = 0.1;
evolutionRuns = 50;

% The next two variables are function handles for the typesof player.
% Since both intention output functions accept the same arguments (in the same
% order), we can call the handles without distinction later in the code,
% with the same arguments.

% E.G. Let's say we want player1 to be an AI NN,
% we say: player1_handle = @intentionAI
% if we want it to be a probabilistic one, we say:
% player1_handle = @probablisticIntention

player1_handle = @intentionAI;
player2_handle = @intentionAI2;

% Let them play one game. Check the Workspace variables at the end to see
% what's the score.
% [player1_score, player2_score] = playGame(player1_handle, player2_handle);

%% Create chromosomePool that is able to conquer the map quickly
% chromosomePool(poolSize)=gen_chromosome(nnStruct); %Preallocation
for idx = 1:poolSize
    chromosomePool(idx) = gen_chromosome(nnStruct);
end

figure;
poolSize_local = poolSize;
poolSize_vect = zeros(evolutionRuns,1);
for runNo = 1:evolutionRuns
    idx = 1;
    pool_fitness = ones(poolSize,1);
    while idx <= poolSize_local
        chromosome = chromosomePool(idx);
        result = playWithMap(player1_handle);
        pool_fitness(idx) = result;
        if(~result)
            chromosomePool(idx) = [];
            pool_fitness(idx) = [];
            poolSize_local=poolSize_local - 1;
            continue;
        end
        chromosomePool(idx).fitness = result;
        idx = idx + 1;
    end
    poolSize_local = size(chromosomePool,2)
    poolSize_vect(runNo) = poolSize_local;
    if runNo~= evolutionRuns && poolSize_local < poolSize && poolSize_local ~= 0
        chromosomePool = evolve(chromosomePool);
    end;
    % Plot the history of the pool_size - should show an improvement over
    % time; 
    % The graph shows the number of players left in the pool after each
    % evolution step: the mean number should get higher and higher, meaning
    % that the players can defeat multiple the neutral multiple times in a
    % row.
    subplot(211),plot(poolSize_vect(poolSize_vect~=0));
    % Plot the fitness histogram (fitness is the number of turns in which a
    % player wins so it's the true fitness is inverse proportional to what
    % we see on the histogram. Hence, we want longer bars towards the left
    % of the histogram: players that can defeat the map faster.
    subplot(212),hist(pool_fitness);
end;

%% Evolve by competition
max_fitness = zeros(evolutionRuns,1);
figure;
for runNo = 1:evolutionRuns
    scores = zeros(poolSize_local,1);

    %Setup competition, add scores for fitness
    for idx = 1:poolSize_local
        for jdx = 1:poolSize_local
            if idx ~= jdx
                chromosome = chromosomePool(idx);
                chromosome2 = chromosomePool(jdx);
                [score1, score2] = playGame(player1_handle,player2_handle);
                scores(idx) = scores(idx) + score1;
                scores(jdx) = scores(jdx) + score2;
            end
        end
        disp([int2str(idx) '/' int2str(poolSize_local)])
    end
    
    scores_norm = normc(scores-min(scores)+1);
    for idx = 1:poolSize_local
        chromosomePool(idx).fitness = scores_norm(idx);
    end
    
    if runNo~= evolutionRuns
        chromosomePool = evolve(chromosomePool);
    end;
    max_fitness(runNo)=max(scores);
    disp(runNo)
    subplot(211),plot(max_fitness);
    subplot(212),hist(scores);
end