%affiche_plateau(+Plateau)
%affiche_plateau([[[mais,ble],[ble,sucre]], [1,2],[],[],[]]).

%gprolog --init-goal "[projet],affiche_plateau([[[mais,ble],[ble,sucre]], [],[],[],[]]),halt"

afficher_tas_marchandise([]):-nl.
afficher_tas_marchandise([H|T]):-write(H),write(','),afficher_tas_marchandise(T).

affiche_marchandise([H|T]):-write('tas:'),nl,afficher_tas_marchandise(H),nl,affiche_marchandise(T),nl.

affiche_plateau([Marchandises, Bourse, 
        PositionTrader,ReserveJoueur1,ReserveJoueur2]):-
    write('--MARCHANDISES--'),nl,
    affiche_marchandise(Marchandises),
    nl.