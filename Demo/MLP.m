% XOR input for x1 and x2
input = [0 0; 0 1; 1 0; 1 1];
% Desired output of XOR
output = [0;1;1;0];
% Initialize the bias
bias = [-1 -1 -1];
% Learning coefficient
coeff = 0.7;
% Number of learning iterations
iterations = 10000;
% Calculate weights randomly using seed.
rand('state',sum(100*clock));
weights = -1 +2.*rand(3,3);

for i = 1:iterations
   out = zeros(4,1);
   numIn = length (input(:,1));
   for j = 1:numIn
      % Hidden layer
      Hidden(1) = bias(1,1)*weights(1,1)+ input(j,1)*weights(1,2)+ input(j,2)*weights(1,3);

      % Send data through sigmoid function 1/1+e^-x
      % Note that sigma is a different m file 
      % that I created to run this operation
      x2(1) = 1/(1+exp(-Hidden(1)));
      Hidden(2) = bias(1,2)*weights(2,1)+ input(j,1)*weights(2,2)+ input(j,2)*weights(2,3);
      x2(2) = 1/(1+exp(-Hidden(2)));

      % Output layer
      outLayer = bias(1,3)*weights(3,1) + x2(1)*weights(3,2) + x2(2)*weights(3,3);
      out(j) = 1/(1+exp(-outLayer));
      
      % Adjust delta values of weights
      % For output layer:
      % delta(wi) = xi*delta,
      % delta = (1-actual output)*(desired output - actual output) 
      delta_out = out(j)*(1-out(j))*(output(j)-out(j));
      
      % Propagate the delta backwards into hidden layers
      deltaH(1) = x2(1)*(1-x2(1))*weights(3,2)*delta_out;
      deltaH(2) = x2(2)*(1-x2(2))*weights(3,3)*delta_out;
      
      % Add weight changes to original weights 
      % And use the new weights to repeat process.
      % delta weight = coeff*x*delta
      for k = 1:3
         if k == 1 % Bias cases
            weights(1,k) = weights(1,k) + coeff*bias(1,1)*deltaH(1);
            weights(2,k) = weights(2,k) + coeff*bias(1,2)*deltaH(2);
            weights(3,k) = weights(3,k) + coeff*bias(1,3)*delta_out;
         else % When k=2 or 3 input cases to neurons
            weights(1,k) = weights(1,k) + coeff*input(j,1)*deltaH(1);
            weights(2,k) = weights(2,k) + coeff*input(j,2)*deltaH(2);
            weights(3,k) = weights(3,k) + coeff*x2(k-1)*delta_out;
         end
      end
   end   
end