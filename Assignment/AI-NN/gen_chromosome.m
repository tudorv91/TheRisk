function chromosome = gen_chromosome(nnStruct)

mul_const_weights = 0.01;
mul_const_thresh = 0.1;
thresholdIdx=1;

thresholds = sum(nnStruct);
weightsH = zeros(nnStruct(1),nnStruct(2));
weightsOut = zeros(nnStruct(2),nnStruct(3));

multipliers = randi([1 100], 2, 1);

for hIdx = 1:nnStruct(2)
%     thresholds(thresholdIdx) = randn*mul_const_thresh;
thresholds(thresholdIdx) = randn*mul_const_thresh;    
thresholdIdx = thresholdIdx + 1;
    for inIdx=1:nnStruct(1)
%         weightsH(inIdx,hIdx) = randn*mul_const_weights;
weightsH(inIdx,hIdx) = randn*mul_const_weights;
    end
    for outIdx = 1:nnStruct(3)
%         weightsOut(hIdx,outIdx) = randn*mul_const_weights;
weightsOut(hIdx,outIdx) = randn*mul_const_weights;
    end
end

for i = 1:nnStruct(3)
%     thresholds(thresholdIdx) = randn*mul_const_thresh;
    thresholds(thresholdIdx) = randn;
    thresholdIdx = thresholdIdx + 1;
end

chromosome.weightsH = weightsH;
chromosome.weightsOut = weightsOut;
chromosome.multipliers = multipliers;
chromosome.thresh = thresholds;
end