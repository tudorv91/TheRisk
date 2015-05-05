function chromosome = gen_chromosome

mul_const_weights = 0.01;
mul_const_thresh = 0.001;
thresholdIdx=1;

thresholds = zeros(10,1);
weightsH = zeros(21,7);
weightsOut = zeros(7,3);

multipliers = randi([1 100], 2, 1);

for hIdx = 1:7
    thresholds(thresholdIdx) = rand*mul_const_thresh;
    thresholdIdx = thresholdIdx + 1;
    for inIdx=1:21
        weightsH(inIdx,hIdx) = rand*mul_const_weights;
    end
    for outIdx = 1:3
        weightsOut(hIdx,outIdx) = rand*mul_const_weights;
    end
end

for i = 1:3
    thresholds(thresholdIdx) = rand*mul_const_thresh;
    thresholdIdx = thresholdIdx + 1;
end

chromosome.weightsH = weightsH;
chromosome.weightsOut = weightsOut;
chromosome.multipliers = multipliers;
chromosome.thresh = thresholds;
end