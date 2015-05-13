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
hold on
r = 1.2; axis([-r r -r r])
gplot(C,xy, '-')
s = scatter(xy(:,1),xy(:,2),100*gamestate(:,3),gamestate(:,2),'filled');
s.LineWidth = 0.6;
s.MarkerEdgeColor = 'b';

% Add text labels to points
countryID = num2str(gamestate(:,1));
army = num2str(gamestate(:,3));
c = strcat('ID: ',cellstr(countryID),' Army: ',cellstr(army));
dxy = 0.05; % displacement so the text does not overlay the data points
text(xy(:,1)+dxy, xy(:,2)+dxy, c);

end
