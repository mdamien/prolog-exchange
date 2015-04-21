%affiche_plateau(+Plateau)
%affiche_plateau([[[mais,ble],[ble,sucre]], [1,2],[],[],[]]).

%gprolog --init-goal "[projet],affiche_plateau([[[mais,ble],[ble,sucre]], [],[],[],[]]),halt"

afficher_sous_liste([H|[]]):-write(H),nl.
afficher_sous_liste([H|T]):-write(H),write(','),afficher_sous_liste(T).

afficher_liste([]).
afficher_liste([H|T]):-afficher_sous_liste(H),afficher_liste(T).

affiche_plateau([M, B, PT, RJ1, RJ2]):-
    write('--MARCHANDISES--'),nl,
    afficher_liste(M),nl,
    write('--BOURSE--'),nl,
    afficher_liste(B),nl,
    write('POSITION:'),write(PT),nl,
    write('RJ1:'),afficher_sous_liste(RJ1),
    write('RJ2:'),afficher_sous_liste(RJ2),
    nl.
