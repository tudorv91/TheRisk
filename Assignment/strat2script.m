nnStruct = [3 10 1];
myID = 1;
player = 1;
figure;
gs = init();
for i=1:100
    if player==1
        chromosome = gen_chromosome(nnStruct);
        possibleMoves = findPossibleMoves(myID, gs);
        intention = selectIntention(chromosome, possibleMoves, nnStruct);
        gs = processIntention(intention, gs);
        player = 2;
    else
        intention = randomIntention(player, gs);
        gs = processIntention(intention, gs);
        player = 1;
    end
    pause(0.5);
    visualizeConn(gs);
end

