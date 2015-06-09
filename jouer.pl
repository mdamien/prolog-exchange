% gprolog --init-goal "[jouer],jouer"

:- include(affichage). 
:- include(gen). 
:- include(coup). 

entrer_nombre(X):-read(X),number(X),X > -1,X < 4,!.
entrer_nombre(X):-write('Déplacement invalide, re-essaye: '),entrer_nombre(X).

joueur_suivant('j1','j2').
joueur_suivant('j2','j1').

cls :- put(27),write('[2J'). 

jouer:-
    plateau_depart(P),
    tour('j1',P).

top_pile(Index,M,Top):-
    nth(Index,M,[Top|_]).

%retourne les sommets des deux piles autour du joueur
choix(M,Trader,Choix1, Choix2):-
    bouger_trader(M, Trader, -1, P1),
    bouger_trader(M, Trader, 1, P2),
    top_pile(P1,M,Choix1),
    top_pile(P2,M,Choix2).

choix_fait(Choix1, Choix2, Choix1, Choix2).
choix_fait(Choix1, Choix2, Choix2, Choix1).

tour(J,[M, B, Trader, RJ1, RJ2]):-


    cls,
    affiche_plateau([M, B, Trader, RJ1, RJ2]),

    write('TOUR DE '),write(J),nl,

    coups_possibles([M, B, Trader, RJ1, RJ2], J, CoupsPossibles),
    write('Coups possibles:'),write(CoupsPossibles),nl,

    write('Avancer de combien ? '),
    entrer_nombre(Depl),
    write('avance de '),write(Depl),nl,
    %avancer()
    bouger_trader(M,Trader,Depl,TraderPred),


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
    choix_fait(Choix1,Choix2,Choix, ChoixDrop),
    write(J),write('prend '),write(Choix),nl,
    jouer_coup([M, B, Trader, RJ1, RJ2], [J,Depl,Choix,ChoixDrop], NouveauPlateau),
    joueur_suivant(J,Jsuivant),
    tour(Jsuivant, NouveauPlateau),
    !.
