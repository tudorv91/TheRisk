function [weights, thresholds] = generate_weights
mul_const = 0.01;
thresholdIdx=1;
for hIdx = 1:7
    thresholds(thresholdIdx) = 0.001;
    thresholdIdx = thresholdIdx + 1;
    for inIdx=1:3
        if inIdx~=1
            weights(1,inIdx,hIdx) = rand*mul_const;
            weights(2,inIdx,hIdx) = rand*mul_const;
        else
            weights(1,inIdx,hIdx) = rand*mul_const;
            weights(2,inIdx,hIdx) = rand*mul_const;
        end
    end
end

for i = 1:3
    thresholds(thresholdIdx) = 0.001;
    thresholdIdx = thresholdIdx + 1;
end
end