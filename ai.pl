
%Retourne un element aléatoire de la liste L
random_element(L,X) :-
    length(L,LLength),
    random(1, LLength, R),
    nth(R,L,X)
.

%joue pour chaque joueur une ai particuliére
%ici pour j1
jouer_ia(Plateau, Coup, J):-
    J = 'j1',
    ai_simple_best(Plateau, Coup, J)
.

%joue pour chaque joueur une ai particuliére
%ici pour j2
jouer_ia(Plateau, Coup, J):-
    J = 'j2',
    ai_minimax(Plateau, Coup, J)
.

%AI: Choix alétoire parmis les coups possible
ai_random(Plateau, Coup, _) :-
    coups_possibles(Plateau, CoupsPossibles),
    random_element(CoupsPossibles, Coup)
.

%Returne le score du joueur pour un plateau
score_joueur('j1', [_, B, _, RJ, _], Score):-
    score(RJ, B, Score)
.
score_joueur('j2', [_, B, _, _, RJ], Score):-
    score(RJ, B, Score)
.

%Retourne le score obtenu par un coup
score_coup(Plateau, [_,Move,Keep,Drop], J, Score):-
    jouer_coup(Plateau, [J,Move,Keep,Drop], NouveauPlateau),
    score_joueur(J, NouveauPlateau, Score1),
    joueur_suivant(J,Joueur2),
    score_joueur(Joueur2, Plateau, Score2),
    Score is Score1-Score2
.

%Retourne le coup avec le meilleur score parmis deux coups
meilleur(Coup1, Score1, _, Score2, Coup1, Score1):-
    Score1 > Score2,!.
meilleur(_, _, Coup2, Score2, Coup2, Score2).

%Retourne le meilleur coup à jouer avec un profondeur simple de 1
meilleur_coup(Plateau, [Coup], J, Coup, Score):-
    score_coup(Plateau, Coup, J, Score),!
.
meilleur_coup(Plateau, [Coup1|AutresCoups], J, MeilleurCoup, MeilleurScore):-
    score_coup(Plateau, Coup1, J, Score1),
    meilleur_coup(Plateau, AutresCoups, J, Coup2, Score2),
    meilleur(Coup1, Score1, Coup2, Score2, MeilleurCoup, MeilleurScore)
.

%AI qui regarde juste le meilleur coup a faire à 1 coup à l'avance
ai_simple_best(Plateau, Coup, J) :-
    write('ai simple best réfléchie!'),nl,
    coups_possibles(Plateau, CoupsPossibles),
    meilleur_coup(Plateau, CoupsPossibles, J, Coup, _),!
.

%AI minimax
ai_minimax(Plateau, Coup, J) :-
    write('ai minimax réfléchie!'),
    minimax([Plateau, 'aucun_coup',J, 0], [_,Coup,_,_], _),
    nl,!
.

%Pour un état donné, retourne le meilleur coup minimax
%State = [Plateau, CoupJoue, Joueur, Profondeur]
minimax([Plateau, CoupJoue, Joueur, Profondeur], BestNextState, Score) :-
    Profondeur >= 1,  %Ici, Profondeur MAX est défini
    m_next_states([Plateau, CoupJoue, Joueur, Profondeur], NextStates),
    m_simple_best(NextStates, BestNextState, Score), !
.
minimax(State, BestNextState, Score) :-
    m_next_states(State, NextStates),
    m_best(NextStates, BestNextState, Score), !
.
minimax(State, _, Score) :-
    m_score_state(State, Score)
.

%applique un coup sur un état et renvoi le nouvel état
m_apply_coup([Plateau, _, Joueur, Profondeur], [_,Move,Keep,Drop],
        [NewPlateau, [_,Move,Keep,Drop], NewJoueur, NewProfondeur]):-
        jouer_coup(Plateau, [Joueur,Move,Keep,Drop], NewPlateau),
        joueur_suivant(Joueur, NewJoueur),
        NewProfondeur is Profondeur+1
.

%renvoi les nouveaux états possibles
m_next_states([Plateau, _, Joueur, Profondeur], [AP,BP,CP,DP,EP,FP]):-
    coups_possibles(Plateau, [A,B,C,D,E,F]),
    m_apply_coup([Plateau, _, Joueur, Profondeur], A, AP),
    m_apply_coup([Plateau, _, Joueur, Profondeur], B, BP),
    m_apply_coup([Plateau, _, Joueur, Profondeur], C, CP),
    m_apply_coup([Plateau, _, Joueur, Profondeur], D, DP),
    m_apply_coup([Plateau, _, Joueur, Profondeur], E, EP),
    m_apply_coup([Plateau, _, Joueur, Profondeur], F, FP)
.

%renvoi vrai si le score du joueur est à minimiser
m_min_to_move([_,_,_,P]):-
    Pm is P mod 2,
    Pm is 1
.

%retourne le score de l'état
m_score_state([Plateau, _, Joueur, _], Score):-
    score_joueur(Joueur, Plateau, Score1),
    joueur_suivant(Joueur,Joueur2),
    score_joueur(Joueur2, Plateau, Score2),
    Score is Score1-Score2
.

%retourne le meilleur état maximisant le score et le score associé en appelant récursivement minimax
m_best([State], State, Score) :-
    minimax(State, _, Score), !
.
m_best([State1 | States], BestState, BestScore) :-
    minimax(State1, _, Score1),
    m_best(States, State2, Score2),
    m_better_of_two(State1, Score1, State2, Score2, BestState, BestScore)
.

%retourne le meilleur état sans appel récursif
m_simple_best([State], State, Score) :-
    m_score_state(State, Score), !
.
m_simple_best([State1 | States], BestState, BestScore) :-
    m_score_state(State1, Score1),
    m_simple_best(States, State2, Score2),
    m_better_of_two(State1, Score1, State2, Score2, BestState, BestScore)
.

%retourne l'état avec le plus grand score entre deux états et deux scores
m_better_of_two(State0, Score0, _, Score1, State0, Score0) :-
    m_min_to_move(State0),
    Score0 > Score1, !
    .
m_better_of_two(State0, Score0, _, Score1, State0, Score0) :-
    Score0 < Score1, !
.
m_better_of_two(_, _, State1, Score1, State1, Score1).
