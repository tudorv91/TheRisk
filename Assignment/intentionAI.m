function intention = intentionAI(myID, gs)

global nnStruct chromosome
% Find all possible moves for the NN AI
possible_int = findPossibleMoves(myID, gs);
if isempty(possible_int)
    intention = 0;
    return
end

% Compute all outputs for the possible moves
% Store them in a vector
% possible_int
results = zeros(size(possible_int,1),1);
for i=1:size(possible_int,1)
    % Retrieve decision weights (
   results(i) = out_MLP(nnStruct, chromosome, squeeze(possible_int(i,:)));
end

[~, idx] = max(results);

% If more than intention results in a MAX value, output the first one
selected_move = possible_int(idx(1),:);
if numel(idx)==0
    % No possible moves. Output warning 0-value
    intention = 0;
    return;
end

% Format the intention vector
intention(1) = myID;
intention(2) = selected_move(3)-1;
intention(3) = selected_move(1);
intention(4) = selected_move(2);