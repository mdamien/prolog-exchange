:- include(affichage). 
:- include(gen). 
:- include(coup). 

jouer:-
    plateau_depart(P),
    affiche_plateau(P),
    write('TOUR DE J1'),nl,
    write('Avancer de combien ? '),
    read_number(Choix),
    write(Choix),nl,
    write('Que prendre entre X et Y ? '),
    read_token(Choix2),
    write(Choix2),nl,
    !.
