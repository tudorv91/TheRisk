function gs = turn(player_handle, player, gs)

global viewGameDevelopment nIncome
disp([ '[turn] of player: ' num2str(player)] );

%% Give the player its income
gs(gs(:,2)==player,3) = gs(gs(:,2)==player,3)+nIncome;

%% Retrieve the intention of the player to move
intention = player_handle(player, gs);

%% Update the gamestate
gs = processIntention(intention, gs);

if viewGameDevelopment
    visualizeConn(gs);
end

end