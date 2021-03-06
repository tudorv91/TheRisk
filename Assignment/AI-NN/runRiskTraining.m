close all
clear all
idx = 1;
%first pass
noGamestates = 20;
majorLoops = 500;
desired_pool_size = 100;
nnStruct = [63 21 3];
fit = 0;

if (~exist('pool','var'))
    gamestates = generate_gamestate_pool(noGamestates);
    for k = 1:majorLoops
        for i = 1:noGamestates
            gamestate = squeeze(gamestates(randi([1 noGamestates],1,1),:,:));
            chromosome = gen_chromosome(nnStruct);
            curr = out_MLP(nnStruct, chromosome, gamestate);
            
            if checkOutput(gamestate,curr)
                pool(idx) = chromosome;
                idx = idx + 1;
            end
        end
        disp(['Finished ' int2str(k) ' out of ' int2str(majorLoops)]);
    end
end

in_use_pool = pool;

% second pass
passNo = 1;
while size(in_use_pool,2)>desired_pool_size
    idx = 1;
    disp(['Executing pass ' int2str(passNo) '. Pool size too big (' ...
        int2str(size(in_use_pool,2)) '>' int2str(desired_pool_size) ')']);
    for i = 1:size(in_use_pool,2)
        gamestate = squeeze(gamestates(randi([1 noGamestates],1,1),:,:));
        curr = out_MLP(nnStruct, in_use_pool(i), gamestate);
        
        if checkOutput(gamestate,curr)
            pool2(idx)=in_use_pool(i);
            idx = idx + 1;
        end
    end
    if idx == 1
        break;
    end
    valid(passNo) = idx-1;
    in_use_pool = pool2;
    clear pool2
    disp(['Done pass ' int2str(passNo)]);
    passNo = passNo + 1;
end

for genIdx = 1:size(in_use_pool,2)
    in_use_pool(genIdx).fitness = 0;
    for gStateIdx = 1:noGamestates
        gamestate = squeeze(gamestates(gStateIdx,:,:));
        curr = out_MLP(nnStruct, in_use_pool(genIdx), gamestate);
        
        if checkOutput(gamestate,curr)
            in_use_pool(genIdx).fitness = in_use_pool(genIdx).fitness+1;
        end
    end
    in_use_pool(genIdx).fitness = in_use_pool(genIdx).fitness/noGamestates;
    fit(genIdx) = in_use_pool(genIdx).fitness;
end

% evolve_children_only(in_use_pool,gamestates);
evolve_with_parents(in_use_pool, nnStruct, gamestates, fit)