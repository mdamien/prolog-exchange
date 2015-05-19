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

tour(J,P):-
    cls,
    affiche_plateau(P),
    write('TOUR DE '),write(J),nl,
    write('Avancer de combien ? '),
    entrer_nombre(Depl),
    write('avance de '),write(Depl),nl,
    write('Que prendre entre xxx et yyy ? '),
    read(Choix),
    write(J),write(' avance de '),write(Depl),write('et prend '),write(Choix),nl,
    %jouer_coup(J, Depl, Choix, P),
    joueur_suivant(J,Jsuivant),
    tour(Jsuivant, P),
    !.
