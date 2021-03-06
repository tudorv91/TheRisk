function child_DNA = evolve(parent1, parent2, mutation_rate)

if parent1.fitness > parent2.fitness
    child_DNA = parent1;
    weak_DNA = parent2;
    dominant_fit = parent1.fitness;
    weak_fit = parent2.fitness;
else
    child_DNA = parent2;
    weak_DNA = parent1;
    dominant_fit = parent2.fitness;
    weak_fit = parent1.fitness;
end
whole_fit = weak_fit + dominant_fit;

% Evolve hidden weights and thresholds
for hIdx = 1:size(child_DNA.weightsH,2)
    for inIdx = 1:size(child_DNA.weightsH,1)
        
        perm = round((weak_fit/dominant_fit)*rand*(1-mutation_rate));
        if (~isnan(perm) && perm)
            child_DNA.weightsH(inIdx,hIdx) = weak_DNA.weightsH(inIdx,hIdx);
        end
    end
    perm = round((weak_fit/dominant_fit)*rand*(1-mutation_rate));
    if (~isnan(perm) && perm)
        child_DNA.thresh(hIdx) = weak_DNA.thresh(hIdx);
    else
        child_DNA.thresh(hIdx) = child_DNA.thresh(hIdx)*(1-mutation_rate) + rand * mutation_rate/100;
    end
end

% Evolve weights and thresholds for the output neurons
for outIdx = 1:size(child_DNA.weightsOut,2)
    for hIdx = 1:size(child_DNA.weightsOut,1)
        perm = round((weak_fit/dominant_fit)*rand*(1-mutation_rate));
        if (~isnan(perm) && perm)
            child_DNA.weightsOut(hIdx,outIdx) = weak_DNA.weightsOut(hIdx,outIdx);
        else
            child_DNA.weightsOut(hIdx,outIdx) = child_DNA.weightsOut(hIdx, outIdx) * (1-mutation_rate) ...
                + rand * mutation_rate/100;
        end
    end
    perm = round((weak_fit/dominant_fit)*rand*(1-mutation_rate));
    oIdxThresh = outIdx+size(child_DNA.weightsOut,1);
    if (~isnan(perm) && perm)
        child_DNA.thresh(oIdxThresh) = weak_DNA.thresh(oIdxThresh);
    else
        child_DNA.thresh(oIdxThresh) = child_DNA.thresh(oIdxThresh)*(1-mutation_rate) ...
            + rand * mutation_rate/100;
    end
end

% Evolve the scaling multipliers (remember - multipliers are needed because
% output of every neuron is in the range [0.5 1] and some output values may
% need to have a bigger dynamic range
for idx = 1:size(child_DNA.multipliers,2)
    mutate = randi([0 1],1,1);
    if mutate
        child_DNA.multipliers(idx) = mutation_rate * randi([1 100], 1, 1)/2 + (1-mutation_rate/2)*...
            (child_DNA.fitness * child_DNA.multipliers(idx) + weak_DNA.fitness * weak_DNA.multipliers(idx))/whole_fit;
    end
end
