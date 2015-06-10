function intention = humanIntention(player,gs)

visualizeConn(gs);

possible_moves = findPossibleMoves(player,gs)

id = 0;
while id < 1 || id > size(possible_moves,1);
    id = input('Enter desired move: ')
end

intention = [player possible_moves(id,3)-1 possible_moves(id,1) possible_moves(id,2)];

end