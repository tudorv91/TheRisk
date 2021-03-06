function [offspring_1, offspring_2] = evolve_crossover(parent1, parent2, mutation_rate)

crossover_rate = 1;
mutation_epochs = 120;
% Doing the crossover on separate layers, where the atomic values are
% individual weights => this step does NOT alter the individual weights,
% just possibly swaps them between the offsprings.

% Do the lottery for every DNA sequence (hidden and output layers weights;
% thresholds; multipliers)
offspring_1 = parent1;
offspring_2 = parent2;

mr_1 = (1-parent1.fitness)*mutation_rate;
mr_2 = (1-parent2.fitness)*mutation_rate;
enableCross = round(crossover_rate * rand);
if enableCross
    cross_p = randi([2 size(parent1.weightsH,1)],1,1);
    offspring_1.weightsH(cross_p:end,:) = parent2.weightsH(cross_p:end,:);
    offspring_2.weightsH(cross_p:end,:) = parent1.weightsH(cross_p:end,:);
end

% Proceed with crossover for the output weights
% enableCross = round(crossover_rate * rand);
if enableCross
    cross_p = randi([1 size(parent1.weightsOut,1)],1,1);
    offspring_1.weightsOut(cross_p:end,:) = parent2.weightsOut(cross_p:end,:);
    offspring_2.weightsOut(cross_p:end,:) = parent1.weightsOut(cross_p:end,:);
end

% Mutation part
for i = 1:mutation_epochs
    
    mx = randi([1 size(offspring_1.weightsH,1)],1,1);
    my = randi([1 size(offspring_1.weightsH,2)],1,1);
    offspring_1.weightsH(mx, my) = mr_1*randn/100 + ...
        (1-mr_1) * offspring_1.weightsH(mx, my);
    
    mx = randi([1 size(offspring_1.weightsH,1)],1,1);
    my = randi([1 size(offspring_1.weightsH,2)],1,1);
    offspring_2.weightsH(mx, my) = mr_2 * randn/100 + ...
        (1-mr_2) * offspring_2.weightsH(mx, my);
    
    mx = randi([1 size(offspring_1.weightsOut,1)],1,1);
    my = randi([1 size(offspring_1.weightsOut,2)],1,1);
    offspring_1.weightsOut(mx, my) = mr_1*randn/100 + ...
        (1-mr_1) * offspring_1.weightsOut(mx, my);
    
    mx = randi([1 size(offspring_1.weightsOut,1)],1,1);
    my = randi([1 size(offspring_1.weightsOut,2)],1,1);
    offspring_2.weightsOut(mx, my) = mr_2*randn/100 + ...
        (1-mr_2) * offspring_2.weightsOut(mx, my);
end

% Proceed with the crossover for the thresholds
% Here, if crossover is done, we compute the weighted sum of the thresholds
% enableCross = round(crossover_rate * rand);
if enableCross
    cross_p = randi([2 size(parent1.thresh,2)],1,1);
    offspring_1.thresh(cross_p:end) = parent2.thresh(cross_p:end);
    offspring_2.thresh(cross_p:end) = parent1.thresh(cross_p:end);
end

threshIdx_mutation = randi([1 size(offspring_2.thresh,2)],1,1);
offspring_1.thresh(threshIdx_mutation) = mr_1*randn/10 + ...
    (1-mr_1) * offspring_1.thresh(threshIdx_mutation);

threshIdx_mutation = randi([1 size(offspring_2.thresh,2)],1,1);
offspring_2.thresh(threshIdx_mutation) = mr_2*randn/10 + ...
    (1-mr_2) * offspring_2.thresh(threshIdx_mutation);

% Proceed with the crossover for the multipliers
% We compute the weighted sum of the thresholds
% enableCross = round(crossover_rate * rand);
if enableCross
    cross_p = randi([1 size(parent1.multipliers,1)],1,1);
    offspring_1.multipliers(cross_p:end,:) = parent2.multipliers(cross_p:end,:);
    offspring_2.multipliers(cross_p:end,:) = parent1.multipliers(cross_p:end,:);
end

offspring_1.fitness = 0;
offspring_2.fitness = 0;
end