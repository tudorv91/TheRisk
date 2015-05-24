function [] = visualizeConn(gamestate)
% Convert gamestate connections into visual overview
% Using a connections matrix with 1's indicating connection
N = length(gamestate);
C = zeros(N,N);
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

%% Plot Connections
C = triu(C); % only need upper triangle of connection matrix
figure(1);
clf
hold on
r = 1.5; axis([-r r -r r])
gplot(C,xy, '-')

%% Plot countries based on player and army
xy0 = [xy ; 1.1 1.1 ; 0.8 1.3 ; 0.5 1.5];
s = scatter(xy0(:,1),xy0(:,2),100*[gamestate(:,3); 2; 2; 2],...
    [gamestate(:,2); 2; 0; 1],'filled');
s.LineWidth = 0.6;
s.MarkerEdgeColor = 'b';

% Add text labels to points
countryID = num2str(gamestate(:,1));
army = num2str(gamestate(:,3));
c = strcat('ID: ',cellstr(countryID),' Army: ',cellstr(army));
c{8,1} = 'Player 2';
c{9,1} = 'Neutral';
c{10,1} = 'Player 1';

dxy = 0.10; % displacement so the text does not overlay the data points
text(xy0(:,1)+dxy, xy0(:,2)+dxy, c);
end
