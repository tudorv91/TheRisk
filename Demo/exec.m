clear

% Training set for basic binary boolean functions.
% First two columns corespond to x1 and x2 and third column is y
% Used both as training set and test set.
% DEFAULT = XOR, change to AND, NAND, NOR, etc for a successful result
training_set = [
    0, 0, 1; 
    0, 1, 1; 
    1, 0, 1; 
    1, 1, 0
    ];

learning_rate = 0.1;
%threshold
t = randn;
%weight vector
w = rand(2,1);

for idx = 1:100000
    % train
[w, t] = trainNN(training_set, w, t, learning_rate);
    % and test
r = testNN(w, t, training_set);
    % if test is successful, stop iterating
if r == 1
    break;
end
end

if r==1
    disp(['Network training successful. ' int2str(idx) ' training epochs.']);
else
    disp('Function could not be fitted after 100000 iterations. The values are note linearly separable!');
end