function child_DNA = evolve(parent1_DNA, parent2_DNA, parent1_fitness, parent2_fitness, mutation_rate)

if parent1_fitness > parent2_fitness
    child_DNA = parent1_DNA;
    weak_DNA = parent2_DNA;
    dominant_fit = parent1_fitness;
    weak_fit = parent2_fitness;
else
    child_DNA = parent2_DNA;
    weak_DNA = parent1_DNA;
    dominant_fit = parent2_fitness;
    weak_fit = parent1_fitness;
end

for blockIdx = 1:size(child_DNA,1)
    for startIdx = 1:size(child_DNA,2)
        for toIdx = 1:size(child_DNA,3)
            chance = rand * mutation_rate;
            whole_fit = parent1_fitness + parent2_fitness;
            rand_mutation = chance * randi([0 1], 1, 1)/100;
            parents_contribution = (1-chance) * (dominant_fit * child_DNA(blockIdx,startIdx,toIdx)/(1-weak_fit) + weak_fit*weak_fit * weak_DNA(blockIdx,startIdx,toIdx))/whole_fit;
            child_DNA(blockIdx,startIdx,toIdx) = rand_mutation + parents_contribution;
        end
    end
end