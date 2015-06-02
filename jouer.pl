% gprolog --init-goal "[jouer],jouer"

:- include(affichage). 
:- include(gen). 
:- include(coup). 

entrer_nombre(X):-read(X),number(X),X > -1,X < 4,!.
entrer_nombre(X):-write('Déplacement invalide, re-essaye: '),entrer_nombre(X).

joueur_suivant(j1,j2).
joueur_suivant(j2,j1).

cls :- put(27),write('[2J'). 

jouer:-
    plateau_depart(P),
    tour(j1,P).

top_pile(Index,M,Top):-
    nth(Index,M,Pile),
    last(Pile,Top).

choix(M,Trader,Choix1,Choix2):-
    avancer_mod(Trader, -1, M, P1),
    avancer_mod(Trader, 1, M, P2),
    top_pile(P1,M,Choix1),
    top_pile(P2,M,Choix2).

avancer_mod(P, D, M, NextP):-
    NextP0 is P+D,
    len(M,Mlen),
    MlenPlus1 is Mlen + 1,
    NextP is NextP0 mod MlenPlus1.

tour(J,[M, B, Trader, RJ1, RJ2]):-
    cls,
    affiche_plateau([M, B, Trader, RJ1, RJ2]),

    write('TOUR DE '),write(J),nl,
    write('Avancer de combien ? '),
    entrer_nombre(Depl),
    write('avance de '),write(Depl),nl,
    %avancer()
    avancer_mod(Trader, Depl, M, TraderPred),
    write('TraderPred:'),write(TraderPred),nl,
    cls,
    choix(M, TraderPred, Choix1,Choix2),

    affiche_plateau([M, B, TraderPred, RJ1, RJ2]),
    write('TOUR DE '),write(J),nl,
    write('Que prendre entre '),
    write(Choix1),
    write(' et '),
    write(Choix2),
    write(' ? '),

    read(Choix),
    write(J),write('prend '),write(Choix),nl,
    %prendre dans pile()
    joueur_suivant(J,Jsuivant),
    tour(Jsuivant, [M, B, TraderPred, RJ1, RJ2]),
    !.
