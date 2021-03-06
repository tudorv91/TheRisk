function [clone, offspring] = evolve_clones(parent1, parent2, mutation_rate)

crossover_rate = 1;

if parent1.fitness < parent2.fitness
    clone = parent1;
    offspring = parent2;
else
    clone = parent2;
    offspring = parent1;
end

divisor = offspring.fitness + clone.fitness;
mutation_epochs = round((numel(offspring.weightsH) + numel(offspring.weightsOut))/10);
mr = offspring.fitness*mutation_rate/divisor;
% mr = (1-offspring.fitness/divisor)*mutation_rate;

enableCross = round(crossover_rate * rand);
if enableCross
    cross_p = randi([2 size(clone.weightsH,1)],1,1);
    offspring.weightsH(cross_p:end,:) = clone.weightsH(cross_p:end,:);
    
    cross_p = randi([1 size(clone.weightsOut,1)],1,1);
    offspring.weightsOut(cross_p:end,:) = clone.weightsOut(cross_p:end,:);
    
    cross_p = randi([2 size(clone.thresh,2)],1,1);
    offspring.thresh(cross_p:end) = clone.thresh(cross_p:end);
    
    cross_p = randi([1 size(clone.multipliers,1)],1,1);
    offspring.multipliers(cross_p:end,:) = clone.multipliers(cross_p:end,:);
end

for i = 1:mutation_epochs 
    mx = randi([1 size(offspring.weightsH,1)],1,1);
    my = randi([1 size(offspring.weightsH,2)],1,1);
    offspring.weightsH(mx, my) = mr * randn/100 + ...
        (1-mr) * offspring.weightsH(mx, my);
    
    mx = randi([1 size(offspring.weightsOut,1)],1,1);
    my = randi([1 size(offspring.weightsOut,2)],1,1);
    offspring.weightsOut(mx, my) = mr*randn/100 + ...
        (1-mr) * offspring.weightsOut(mx, my);
end

threshIdx_mutation = randi([1 size(offspring.thresh,2)],1,1);
offspring.thresh(threshIdx_mutation) = mr*randn/10 + ...
    (1-mr) * offspring.thresh(threshIdx_mutation);

offspring.fitness = 0;
clone.fitness = 0;
end