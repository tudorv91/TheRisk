function out = getOutput(x, w, t)
%calculate the output

out = 0;
for i=1:size(w,1)
   out = out+x(i)*w(i); 
end
out = out - t;
if out < 0
    out = 0;
else
    out = 1;
end
end
