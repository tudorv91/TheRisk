function result = testNN(w, t, test_set)

result = 1;
for i = 1:size(test_set,1)
    y = getOutput(test_set(i,1:end-1),w,t);
    if y ~= test_set(i,end)
        result = 0;
    end
end
end