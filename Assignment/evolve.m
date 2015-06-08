function [pool] = evolve(prev_pool)

global poolSize mutation_rate

prev_pool_size = size(prev_pool,2);
curr_pool_size = 0;

if prev_pool_size>poolSize
    disp('[evolve] prev_pool >= poolSize')
    keyboard
elseif prev_pool_size == 0
    disp('[evolve] prev_pool_size = 0')
    keyboard
    return;
end

pool_fitness = zeros(prev_pool_size,1);
for idx = 1:prev_pool_size
    pool_fitness(idx)=prev_pool(idx).fitness;
end
pool_fitness = 1./pool_fitness; %display pool fitness

counter = 1;
while(curr_pool_size < poolSize)
    
    %Choose between random parents for cloning and mutation or based on
    %fitness distribution. 
%     rand1 = randi([1 prev_pool_size]);
%     rand2 = randi([1 prev_pool_size]);
    [rand] = randsample(1:prev_pool_size,2,true,pool_fitness);
    rand1 = rand(1);
    rand2 = rand(2);
    
    [offspring_1, offspring_2] = evolve_clones(prev_pool(rand1), prev_pool(rand2), mutation_rate);
    pool(counter) = offspring_1;
    counter = counter + 1;
    pool(counter) = offspring_2;
    counter = counter + 1;
    curr_pool_size = size(pool,2);
end

if curr_pool_size == poolSize+1
   pool(end) = []; 
end

end