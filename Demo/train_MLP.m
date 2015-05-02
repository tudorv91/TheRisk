function [weights, biases] = train_MLP(weights, nnStruct, training_set, noIterations, L_rate)

% Calculate and adjust weights for output neurons
for outIdx = 1:nnStruct(3)
   delta = out(outIdx)*(1-out(outIdx))*(expOut(outIdx) - out(outIdx));
   for hIdx = 1:nnStruct(2)
   weights(2,hIdx,outIdx)
   end
end