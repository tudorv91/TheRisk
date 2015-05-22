function intention = selectIntention(chromosome, gs, nnStruct, myID)

possible_int = findPossibleMoves(myID, gs);
if isempty(possible_int)
    intention = 0;
    return
end



results = zeros(size(possible_int,1),1);
for i=1:size(possible_int,1)
   results(i) = out_MLP(nnStruct, chromosome, squeeze(possible_int(i,:)));
end

[max_val, idx] = max(results);

% If more than intention results in a MAX value, output the first one
selected_move = possible_int(idx(1),:);
intention(1) = 1;
intention(2) = selected_move(3)-1;
intention(3) = selected_move(1);
intention(4) = selected_move(2);
end