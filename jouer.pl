% gprolog --init-goal "[jouer],jouer"

:- include(affichage). 
:- include(gen). 
:- include(coup). 

entrer_nombre(X):-read(X),number(X),X > -1,X < 4,!.
entrer_nombre(X):-write('Nombre invalide, re-essaye: '),entrer_nombre(X).

joueur_suivant(j1,j2).
joueur_suivant(j2,j1).

cls :- put(27),write('[2J'). 

jouer:-
    plateau_depart(P),
    tour(j1,P).

top_pile(Index,M,Top):-
    nth(Index,M,Pile),
    last(Pile,Top).

choix([M,_,Trader,_,_],Choix1,Choix2):-
    P1 is Trader-1,
    P2 is Trader+1,
    top_pile(P1,M,Choix1),
    top_pile(P2,M,Choix2).

tour(J,P):-
    cls,
    affiche_plateau(P),

    write('TOUR DE '),write(J),nl,
    write('Avancer de combien ? '),
    entrer_nombre(Depl),
    write('avance de '),write(Depl),nl,
    %avancer()
    choix(P,Choix1,Choix2),

    write('Que prendre entre '),
    write(Choix1),
    write(' et '),
    write(Choix2),
    write(' ? '),

    read(Choix),
    write(J),write('prend '),write(Choix),nl,
    %prendre dans pile()
    joueur_suivant(J,Jsuivant),
    tour(Jsuivant, P),
    !.
