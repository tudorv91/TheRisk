function out = out_MLP(nnStruct, weightsH, weightsOut, thresholds, multipliers, input)

hiddenOut = zeros(nnStruct(2),1);
out = zeros(nnStruct(3),1);
thresholdsIdx = 1;

for hIdx=1:nnStruct(2) % Iterate through input nodes
    % Calculate inputs for the hidden layer
    hIn = 0;
    for xIdx=1:nnStruct(1)
        hIn = hIn+weightsH(xIdx,hIdx)*input(xIdx);
    end
    hIn = hIn - thresholds(thresholdsIdx);
    thresholdsIdx = thresholdsIdx +1;
    % Apply activation function and calculate output
    hiddenOut(hIdx) = (1/(1+exp(-hIn))-0.5)*multipliers(1);
end

% Apply same step for the output of the network
for outIdx = 1:nnStruct(3)
    oIn = 0;
    for hIdx = 1:nnStruct(2)
        oIn = oIn + weightsOut(hIdx,outIdx)*hiddenOut(hIdx);
    end
    oIn = oIn - thresholds(thresholdsIdx);
    thresholdsIdx = thresholdsIdx + 1;
    out(outIdx) = (1/(1+exp(-oIn))-0.5)*multipliers(2);
end
out = round(out);