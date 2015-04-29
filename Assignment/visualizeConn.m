function [] = visualizeConn(gamestate)

% Convert gamestate connections into visual overview
% Using a connections matrix with 1's indicating connection
N = length(gamestate);
C = sparse(N,N);
xy = zeros(N,2);

for i = 1:N
    %extract connections
    connectedCntries = num2str(gamestate(i,4));
    NconnectedCntries = length(connectedCntries);
    for j = 1:NconnectedCntries
        C(i,str2double(connectedCntries(j))) = 1;    % Set 1 for connection between i and j
        [xy(i,1) ,xy(i,2)] = pol2cart(i/N*2*pi(),1); % Set some location for each country
    end
end

C = triu(C); % only need upper triangle of connection matrix
figure;
gplot(C,xy, '-*')

% Add text labels to points
a = [1:N]'; b = num2str(a); c = cellstr(b);
dxy = 0.05; % displacement so the text does not overlay the data points
text(xy(:,1)+dxy, xy(:,2)+dxy, c);

end
