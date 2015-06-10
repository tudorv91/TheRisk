
load workspace42

global chromosome

chromosome = gen_chromosome(nnStruct);
player1_handle = @intentionAI;
player2_handle = @humanIntention;

[score1, score2] = playGame(player1_handle,player2_handle);

[M, I] = max(pool_fitness);
chromosome = chromosomePoolInit(I);
[score1, score2] = playGame(player1_handle,player2_handle)

[M, I] = max(scores)
chromosome = chromosomePool(I);
[score1, score2] = playGame(player1_handle,player2_handle)