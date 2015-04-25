function [w, t] = trainNN(training_set, w, t, learning_rate)

%training set
randIdx = randi(size(training_set,1),1,1);

x(1) = training_set(randIdx, 1);
x(2) = training_set(randIdx, 2);
Yd = training_set(randIdx, 3);

%calculate the output
y = getOutput(x,w,t);

err = (Yd - y);
for i=1:size(w,1)
   w(i) = w(i) + x(i)*err*learning_rate;
end
t = t-err*(learning_rate);