
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

%%%% profondeur >1
jouer_all(Plateau, J, [[_,Move,Keep,Drop]|[]], ListePlateaux) :-
   jouer_coup(Plateau, [J,Move,Keep,Drop], ListePlateaux),!
.

jouer_all(Plateau, J, [[_,Move,Keep,Drop]|Autres], ListePlateaux) :-
   jouer_all(Plateau, J, Autres, Liste),
   jouer_coup(Plateau, [J,Move,Keep,Drop], NewPlateau),
   concat([NewPlateau],Liste, ListePlateaux)
.

ai_complexe_best(Plateau, BestCoup, Score, J, 1, CoupAppel) :-
   coups_possibles(Plateau, CoupsPossibles),
   meilleur_coup(Plateau, CoupsPossibles, J, _, Score),
   BestCoup is CoupAppel,!
.

ai_complexe_best([Plateau|AutresP], BestCoup, Score, J, 1) :-
   coups_possibles(Plateau, CoupsPossibles),
   meilleur_coup(Plateau, CoupsPossibles, J, Coup1, Score1),
   ai_complexe_best(AutresP, Coup2, Score2, J,1),
   meilleur(Coup1, Score1, Coup2, Score2, BestCoup, Score),!
.

ai_complexe_best(Plateau, BestCoup, Score, J, Profondeur, CoupAppel) :-
   coups_possibles(Plateau, CoupsPossibles),
   jouer_all(Plateau, J, CoupsPossibles, ListePlateaux),
   joueur_suivant(J,NJ),
   NProf is Profondeur-1,
   ai_complexe_best(ListePlateaux,BestCoup,Score,NJ,NProf),!
.

ai_complexe_best([Plateau|Autres], BestCoup, Score, J, Profondeur, [CoupAppel|AutresCA]) :-
   coups_possibles(Plateau, [CoupP1|AutresCP]),
   jouer_all(Plateau, J, [CoupP1|AutresCP], ListePlateaux),
   joueur_suivant(J,NJ),
   NProf is Profondeur-1,
   ai_complexe_best(Autres, Coup2, Score2, J, Profondeur, AutresCA),

   ai_complexe_best(ListePlateaux,Coup1,Score1, NJ, NProf),
   meilleur(CoupAppel, Score1, Coup2, Score2, BestCoup, Score)
.
