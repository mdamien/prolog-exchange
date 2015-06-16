:- include(affichage).
:- include(gen).
:- include(coup).
:- include(ai).
:- include(tools).

entrer_nombre(X):-read(X),number(X),X > -1,X < 4,!.
entrer_nombre(X):-write('Déplacement invalide, re-essaye: '),entrer_nombre(X).

choix_fait_avec_nombre(1, C, _,C).
choix_fait_avec_nombre(_, _, C,C).

entrer_choix(C1, C2, C):-read(X),number(X),X > 0,X < 3,choix_fait_avec_nombre(X, C1,C2,C),!.
entrer_choix(C1, C2, C):-write('Choix invalide, re-essaye: '),entrer_choix(C1,C2,C).

joueur_suivant('j1','j2').
joueur_suivant('j2','j1').

%cls :- put(27),write('[2J').  %clear screen
cls :- nl,nl,nl,write('_________________'),nl,nl,nl,nl.

jouer:-
    jouer_h_vs_h.

jouer_h_vs_h:-
    plateau_depart(P),
    tour('j1',P,'Humain','Humain',1).

jouer_ia_vs_ia:-
    plateau_depart(P),
    tour('j1',P,'IA','IA',1).

jouer_h_vs_ia:-
    plateau_depart(P),
    tour('j1',P,'Humain','IA',1).

choix_fait(Choix1, Choix2, Choix1, Choix2).
choix_fait(Choix1, Choix2, Choix2, Choix1).

curr_role('j1',J1role,_,J1role).
curr_role('j2',_,J2role,J2role).

gagnant(ScoreJ1, ScoreJ2, 'j1'):-
    ScoreJ1 > ScoreJ2.
gagnant(ScoreJ1, ScoreJ1, 'j1 et j2').
gagnant(_, _, 'j2').

%Tour Fin du jeu
tour(_,[M, B, Trader, RJ1, RJ2], _, _, _):-
    fin_jeu(M),!,
    affiche_plateau([M, B, Trader, RJ1, RJ2]),
    nl,bold('FIN DE LA PARTIE!'),nl,
    score(RJ1,B, ScoreJ1),
    write('Score J1: '),write(ScoreJ1),nl,
    score(RJ2,B, ScoreJ2),
    write('Score J2: '),write(ScoreJ2),nl,
    gagnant(ScoreJ1,ScoreJ2, Gagnant),nl,nl,
    write('         GAGNANT:' ),write(Gagnant),
    nl,nl,nl,
    !.

%Tour AI
tour(J,[M, B, Trader, RJ1, RJ2], J1role, J2role, TourNumber):-
    curr_role(J, J1role, J2role, CurrRole),
    CurrRole = 'IA',!,
    cls,
    bold('TOUR DE '),bold(J),bold(' [IA] -T'),bold(TourNumber),bold('-'),nl,
    affiche_plateau([M, B, Trader, RJ1, RJ2]),
    jouer_ia([M, B, Trader, RJ1, RJ2], [_,D,Keep,Drop], J),
    write('AI choisit d\'avancer de -'),write(D),
    write('-, de prendre le -'),write(Keep),
    write('- et de jeter le -'),write(Drop),write('- '),
    nl,
    jouer_coup([M, B, Trader, RJ1, RJ2], [J,D,Keep,Drop], NouveauPlateau),
    joueur_suivant(J,Jsuivant),
    TourNumberP1 is TourNumber + 1,
    %write('Tapez "1" pour continuer...'),read(IOP),
    cls,
    tour(Jsuivant, NouveauPlateau, J1role, J2role, TourNumberP1),
    !.

%Tour Humain
tour(J,[M, B, Trader, RJ1, RJ2], J1role, J2role, TourNumber):-
    curr_role(J, J1role, J2role, CurrRole),
    CurrRole = 'Humain',!,

    cls,

    bold('TOUR DE '),bold(J),bold(' [Humain] -T'),bold(TourNumber),bold('-'),nl,


    affiche_plateau([M, B, Trader, RJ1, RJ2]),

    write('Avancer de combien ? '),
    entrer_nombre(Depl),
    bouger_trader(M,Trader,Depl,TraderPred),

    choix(M, TraderPred, Choix1,Choix2),

    cls,

    bold('TOUR DE '),bold(J),bold(' [Humain] -T'),bold(TourNumber),bold('-'),nl,

    affiche_plateau([M, B, TraderPred, RJ1, RJ2]),

    nl,
    write('Que prendre entre '),
    write(Choix1),red('(1)'),
    write(' et '),
    write(Choix2),red('(2)'),
    write(' ? '),

    entrer_choix(Choix1, Choix2, Choix),
    choix_fait(Choix1,Choix2,Choix, ChoixDrop),
    write(J),write('prend '),write(Choix),nl,
    jouer_coup([M, B, Trader, RJ1, RJ2], [J,Depl,Choix,ChoixDrop], NouveauPlateau),
    joueur_suivant(J,Jsuivant),
    TourNumberP1 is TourNumber + 1,
    tour(Jsuivant, NouveauPlateau, J1role, J2role, TourNumberP1),
    !.
