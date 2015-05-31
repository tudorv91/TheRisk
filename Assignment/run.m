format compact
clc
clear
close all
addpath('./AI-NN')

% % Section used for globals (avoid transmitting all parameters as arguments)
% % All initial game conditions should be specified here (session setup)
global nnStruct chromosome noRounds viewGameDevelopment pauseTime nIncome poolSize mutation_rate

viewGameDevelopment = 0;
nnStruct = [3 10 1];
chromosome = gen_chromosome(nnStruct);
noRounds = 100;
pauseTime = 0;
nIncome = 2;
poolSize = 100;
mutation_rate = 0.1;
evolutionRuns = 100;

% The next two variables are function handles for the typesof player.
% Since both intention output functions accept the same arguments (in the same
% order), we can call the handles without distinction later in the code,
% with the same arguments.

% E.G. Let's say we want player1 to be an AI NN,
% we say: player1_handle = @intentionAI
% if we want it to be a probabilistic one, we say:
% player1_handle = @probablisticIntention

player1_handle = @intentionAI;
player2_handle = @probablisticIntention;

% Let them play one game. Check the Workspace variables at the end to see
% what's the score.
% [player1_score, player2_score] = playGame(player1_handle, player2_handle);

for idx = 1:poolSize
    chromosomePool(idx) = gen_chromosome(nnStruct);
end

figure;
poolSize_local = poolSize;
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
    if runNo~= evolutionRuns && poolSize_local < poolSize
        chromosomePool = evolve(chromosomePool);
    end;
    % Plot the history of the pool_size - should show an improvement over
    % time; 
    % The graph shows the number of players left in the pool after each
    % evolution step: the mean number should get higher and higher, meaning
    % that the players can defeat multiple the neutral multiple times in a
    % row.
    subplot(211),plot(poolSize_vect);
    % Plot the fitness histogram (fitness is the number of turns in which a
    % player wins so it's the true fitness is inverse proportional to what
    % we see on the histogram. Hence, we want longer bars towards the left
    % of the histogram: players that can defeat the map faster.
    subplot(212),hist(pool_fitness);
end;
