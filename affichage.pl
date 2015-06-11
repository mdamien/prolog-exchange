%gprolog --init-goal "[affichage],gPlateauTest(Y),affiche_plateau(Y),halt"
gPlateauTest([
    [[mais,ble],[ble,sucre]],[[mais,1],[ble,2]],
    [1,9],[ble,ble],[sucre,sucre]]).

afficher_sous_liste([]):-write('vide').
afficher_sous_liste([H|[]]):-write(H).
afficher_sous_liste([H|T]):-write(H),write(','),afficher_sous_liste(T).

afficher_liste([]).
afficher_liste([H|T]):-afficher_sous_liste(H),nl,afficher_liste(T).

afficher_val_bourse([P,V]):-write(P),write(' '),write(V).

afficher_bourse([]).
afficher_bourse([H|T]):-afficher_val_bourse(H),write('|'),afficher_bourse(T).

afficher_pos(P,P):-write('(T)').
afficher_pos(_,_).

afficher_marchs([],_,_).
afficher_marchs([[H1|HR]|T],P,I):-
    write(H1),afficher_pos(P,I),
    write(' '),J is I+1,afficher_marchs(T,P,J).

affiche_plateau([M, B, PT, RJ1, RJ2]):-
    write('TAS: '),
    afficher_marchs(M,PT,1),nl,
    write('BOURSE: '),
    write('|'),afficher_bourse(B),nl,
    write('Réserve J1: '),afficher_sous_liste(RJ1),nl,
    write('Réserve J2: '),afficher_sous_liste(RJ2),nl,
    nl,!.
