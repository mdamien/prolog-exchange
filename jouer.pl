% gprolog --init-goal '[jouer],jouer'

:- include(affichage). 
:- include(gen). 
:- include(coup). 
:- include(ai). 

entrer_nombre(X):-read(X),number(X),X > -1,X < 4,!.
entrer_nombre(X):-write('Déplacement invalide, re-essaye: '),entrer_nombre(X).

joueur_suivant('j1','j2').
joueur_suivant('j2','j1').

cls :- put(27),write('[2J'). 

jouer:-
    jouer_h_vs_h.

jouer_h_vs_h:-
    plateau_depart(P),
    tour('j1',P,'Humain','Humain').

jouer_ia_vs_ia:-
    plateau_depart(P),
    tour('j1',P,'IA','IA').

jouer_h_vs_ia:-
    plateau_depart(P),
    tour('j1',P,'Humain','IA').

choix_fait(Choix1, Choix2, Choix1, Choix2).
choix_fait(Choix1, Choix2, Choix2, Choix1).

curr_role(j1,J1role,_,J1role).
curr_role(j2,_,J2role,J2role).

%Tour AI
tour(J,[M, B, Trader, RJ1, RJ2], J1role, J2role):-
    curr_role(J, J1role, J2role, CurrRole),
    CurrRole = 'IA',
    write('TOUR DE '),write(J),write(' [IA]'),nl,
    ai_random([M, B, Trader, RJ1, RJ2], [_,D,Keep,Drop]),
    write('AI choisit d avancer de -'),write(D),
    write('-, de prendre le -'),write(Keep),
    write('- et de laisser -'),write(Drop),write('- '),nl,
    jouer_coup([M, B, Trader, RJ1, RJ2], [J,D,Keep,Drop], NouveauPlateau),
    joueur_suivant(J,Jsuivant),
    affiche_plateau([M, B, Trader, RJ1, RJ2]),nl,
    tour(Jsuivant, NouveauPlateau, J1role, J2role),
    nl.

%Tour Humain
tour(J,[M, B, Trader, RJ1, RJ2], J1role, J2role):-
    curr_role(J, J1role, J2role, CurrRole),
    CurrRole = 'Humain',

    cls, affiche_plateau([M, B, Trader, RJ1, RJ2]),

    write('TOUR DE '),write(J),write(' [Humain]'),nl,

    write('Avancer de combien ? '),
    entrer_nombre(Depl),
    write('avance de '),write(Depl),nl,
    bouger_trader(M,Trader,Depl,TraderPred),

    cls,
    choix(M, TraderPred, Choix1,Choix2),
    affiche_plateau([M, B, TraderPred, RJ1, RJ2]),
    write('TOUR DE '),write(J),write(' [Humain]'),nl,
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
    tour(Jsuivant, NouveauPlateau, J1role, J2role),
    !.