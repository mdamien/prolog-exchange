
random_element(L,X) :-
    length(L,LLength),
    random(1, LLength, R),
    nth(R,L,X).

ai_random(Plateau, Coup) :-
    write('ai random réfléchie!'),nl,
    coups_possibles(Plateau, CoupsPossibles),
    write('coup possibles ok!'),nl,
    random_element(CoupsPossibles, Coup).
