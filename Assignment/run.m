format compact
clc
clear
close all
addpath('./AI-NN')

% Section used for globals (avoid transmitting all parameters as arguments)
% All initial game conditions should be specified here (session setup)
global nnStruct chromosome noRounds viewGameDevelopment pauseTime nIncome;

viewGameDevelopment = 1;
nnStruct = [3 3 1];
chromosome = gen_chromosome(nnStruct);
noRounds = 100;
pauseTime = 0.5;
nIncome = 2;

% The next two variables are function handles for the typesof player. 
% Since both intention output functions accept the same arguments (in the same
% order), we can call the handles without distinction later in the code,
% with the same arguments. 

% E.G. Let's say we want player1 to be an AI NN, 
% we say: player1_handle = @intentionAI
% if we want it to be a probabilistic one, we say:
% player1_handle = @probablisticIntention

player1_handle = @intentionAI;
player2_handle = @probablisticIntention;

% Let them play one game. Check the Workspace variables at the end to see
% what's the score.
[player1_score, player2_score] = playGame(player1_handle, player2_handle);