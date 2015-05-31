function pool = evolve(prev_pool)

global poolSize mutation_rate

curr_pool_size = size(prev_pool,2);
counter = 1;

if size(prev_pool,2) == 0
    return;
end;

while(curr_pool_size < poolSize)
    rand1 = randi([1 size(prev_pool,2)]);
    rand2 = randi([1 size(prev_pool,2)]);
    [offspring_1, offspring_2] = evolve_clones(prev_pool(rand1), prev_pool(rand2), mutation_rate);
    pool(counter) = offspring_1;
    counter = counter + 1;
    pool(counter) = offspring_2;
    counter = counter + 1;
    curr_pool_size = size(pool,2);
end
end