
random_element(L,X) :-
    length(L,LLength),
    random(1, LLength, R),
    nth(R,L,X).

ai_random(Plateau, Coup) :-
    write('ai random réfléchie!'),nl,
    coups_possibles(Plateau, CoupsPossibles),
    random_element(CoupsPossibles, Coup).

best_element(CoupsPossibles, _, Coup):-
    random_element(CoupsPossibles, Coup).

ai_simple_best(Plateau, Coup) :-
    write('ai simple best réfléchie!'),nl,
    coups_possibles(Plateau, CoupsPossibles),
    best_element(CoupsPossibles, 2, Coup).

% node = [Plateau, J]

heuristic(_, Score):-
    Score = 1
.

minimax(Node, 0):-
    heuristic(Node,223)
.

ai_minimax(Plateau, Coup) :-
    write('ai minimax réfléchie!'),nl,
    minimax(Plateau, 2)
.