function victor = game(playerType1, playerType2, initialGameState)
% victor, playertype1 and 2 are strings representing the players

% Grab the gamestate
localGamestate = initialGameState;

for i = 1:10
    %  Let player 1 make a move
    switch playerType1
        case 'probabilistic'
            intention = probabilisticIntention(1,localGamestate);
        case 'NN'
            nnStruct = globals();
            chromosome = gen_chromosome(nnStruct);
            possibleMoves = findPossibleMoves(1, localGamesate);
            intention = selectIntention(chromosome, possibleMoves,nnStruct);
        case 'random'
            intention = randomIntention(1, localGamestate);
    end

    % Process intention for player 1
    localGamestate = processIntention(intention, localGamestate);
    %visualise
    pause(0.5);
    visualizeConn(localGamestate);
    
     % Stop the loop if one player has no more countries
    player1_countries = localGamestate(numel(find(localGamestate(:,2)==1)));
    player2_countries = localGamestate(numel(find(localGamestate(:,2)==2)));
    if player1_countries == 0 || player2_countries == 0
        break
    end

    %Let player 2 make a move
    switch playerType2
        case 'probabilistic'
            intention = probabilisticIntention(2,localGamestate);
        case 'NN'
            nnStruct = globals();
            chromosome = gen_chromosome(nnStruct);
            possibleMoves = findPossibleMoves(2, localGamesate);
            intention = selectIntention(chromosome, possibleMoves,nnStruct);
        case 'random'
            intention = randomIntention(2, localGamestate);
    end

    % Process intention for player 2
    localGamestate = processIntention(intention, localGamestate);
    %visualise
    pause(0.5);
    visualizeConn(localGamestate);
    
    % Stop the loop if one player has no more countries
    player1_countries = localGamestate(numel(find(localGamestate(:,2)==1)));
    player2_countries = localGamestate(numel(find(localGamestate(:,2)==2)));
    if player1_countries == 0 || player2_countries == 0
        break
    end
end

% Look at the outcome
player1_countries = localGamestate(numel(find(localGamestate(:,2)==1)));
player2_countries = localGamestate(numel(find(localGamestate(:,2)==2)));

if player1_countries > player2_countries
    victor = 1;
elseif player2_countries > player1_countries
    victor = 2;
else
    victor = 0;
end


