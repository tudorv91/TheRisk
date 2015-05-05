function [offspring_1, offspring_2] = evolve_crossover(parent1, parent2, mutation_rate)

crossover_rate = 0.7;
% Doing the crossover on separate layers, where the atomic values are
% individual weights => this step does NOT alter the individual weights,
% just possibly swaps them between the offsprings.

% Do the lottery for every DNA sequence (hidden and output layers weights;
% thresholds; multipliers)
enableCross = round(crossover_rate * rand);
if enableCross
   cross_p = randi([1 size(parent1.weightsH,1)],1,1);
   offspring_1.weightsH = horzcat(parent1.weightsH(1:cross_p,:), ...
       parent2.weightsH(cross_p+1:end,:));
   offspring_2.weightsH = horzcat(parent2.weightsH(1:cross_p,:), ...
       parent1.weightsH(cross_p+1:end,:));
end

% Proceed with crossover for the output weights
enableCross = round(crossover_rate * rand);
if enableCross
   cross_p = randi([1 size(parent1.weightsOut,1)],1,1);
   offspring_1.weightsOut = horzcat(parent1.weightsOut(1:cross_p,:), ...
       parent2.weightsOut(cross_p+1:end,:));
   offspring_2.weightsOut = horzcat(parent2.weightsOut(1:cross_p,:), ...
       parent1.weightsOut(cross_p+1:end,:));
end

% Proceed with the crossover for the thresholds
% Here, if crossover is done, we compute the weighted sum of the thresholds
enableCross = round(crossover_rate * rand);
if enableCross
    cross_p = rand;
    offspring_1.thresh = cross_p * parent1.thresh + ...
        (1-cross_p) * parent2.thresh;
    offspring_2.thresh = cross_p * parent2.thresh + ...
        (1-cross_p) * parent1.thresh;
end

% Proceed with the crossover for the multipliers
% We compute the weighted sum of the thresholds
enableCross = round(crossover_rate * rand);
if enableCross
    cross_p = rand;
    offspring_1.multipliers = cross_p * parent1.multipliers + ...
        (1-cross_p) * parent2.multipliers;
    offspring_2.multipliers = cross_p * parent2.multipliers + ...
        (1-cross_p) * parent1.multipliers;
end

offspring_1.fitness = 0;
offspring_2.fitness = 0;
end