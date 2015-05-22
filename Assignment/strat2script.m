format compact
clc
clear
close all
addpath('AI-NN')

nnStruct = [3 10 1];
myID = 1;
player = 1;
figure;
gs = init();
nRounds=0;
notWon = true;
while notWon && nRounds<100
    if player==1
        disp('turn of player 1')
        chromosome = gen_chromosome(nnStruct);
        intention = selectIntention(chromosome, gs, nnStruct, player);
        gs = processIntention(intention, gs);
        visualizeConn(gs);
        player = 2;
    else
        disp('turn of player 2')
        intention = probablisticIntention(player, gs);
        gs = processIntention(intention, gs);
        visualizeConn(gs);
        player = 1;
    end
    nRounds = nRounds+1;
    
    [notWon, victor] = whoWon(gs);
    
    pause(0);
    
end