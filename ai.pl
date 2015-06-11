
random_element(L,X) :-
    length(L,LLength),
    random(1, LLength, R),
    nth(R,L,X)
.

ai_random(Plateau, Coup) :-
    %write('ai random réfléchie!'),nl,
    coups_possibles(Plateau, CoupsPossibles),
    random_element(CoupsPossibles, Coup)
.

score_joueur('j1', [_, B, _, RJ, _], Score):-
    score(RJ, B, Score)
.

score_joueur('j2', [_, B, _, _, RJ], Score):-
    score(RJ, B, Score)
.

score_coup(Plateau, [_,Move,Keep,Drop], J, Score):-
    jouer_coup(Plateau, [J,Move,Keep,Drop], NouveauPlateau),
    score_joueur(J, NouveauPlateau, Score)
    %write('Score de '),write([Move,Keep,Drop]),write('  '),write(Score),nl
.

meilleur(Coup1, Score1, _, Score2, Coup1, Score1):-
    %write([Coup1, Score1, Score2, Coup1, Score1]),nl,
    Score1 > Score2,!.
meilleur(_, _, Coup2, Score2, Coup2, Score2).

meilleur_coup(Plateau, [Coup], J, Coup, Score):-
    score_coup(Plateau, Coup, J, Score),!
.

meilleur_coup(Plateau, [Coup1|AutresCoups], J, MeilleurCoup, MeilleurScore):-
    score_coup(Plateau, Coup1, J, Score1),
    meilleur_coup(Plateau, AutresCoups, J, Coup2, Score2),
    meilleur(Coup1, Score1, Coup2, Score2, MeilleurCoup, MeilleurScore)   
.

%regarde juste le meilleur coup a faire a 1 coup à l'avance
ai_simple_best(Plateau, Coup, J) :-
    write('ai simple best réfléchie!'),nl,
    coups_possibles(Plateau, CoupsPossibles),
    meilleur_coup(Plateau, CoupsPossibles, J, Coup, _),!
.