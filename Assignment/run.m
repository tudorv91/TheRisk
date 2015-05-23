format compact
clc
clear
close all
addpath('./AI-NN')

pause = 0.2;

global nnStruct chromosome noRounds viewGameDevelopment pauseTime;

viewGameDevelopment = 1;
nnStruct = [3 3 1];
chromosome = gen_chromosome(nnStruct);
noRounds = 1000;
pauseTime = 0.1;

player1_handle = @probablisticIntention;
player2_handle = @probablisticIntention;

[player1_score, player2_score] = playGame(player1_handle, player2_handle);