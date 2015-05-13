%gprolog --init-goal "[affichage],gPlateauTest(Y),affiche_plateau(Y),halt"
gPlateauTest([
    [[mais,ble],[ble,sucre]],[[mais,1],[ble,2]],
    [1,9],[ble,ble],[sucre,sucre]]).

afficher_sous_liste([]).
afficher_sous_liste([H|[]]):-write(H).
afficher_sous_liste([H|T]):-write(H),write(','),afficher_sous_liste(T).

afficher_liste([]).
afficher_liste([H|T]):-afficher_sous_liste(H),nl,afficher_liste(T).

afficher_val_bourse([P,V]):-write(V),write(' | '),write(P).

afficher_bourse([]).
afficher_bourse([H|T]):-write('| '),afficher_val_bourse(H),nl,afficher_bourse(T).

afficher_pos(P,P):-write('   <----------- Trader').
afficher_pos(_,_).

afficher_marchs([],_,_).
afficher_marchs([H|T],P,I):-write(I),write(': '),afficher_sous_liste(H),afficher_pos(P,I),nl,J is I+1,afficher_marchs(T,P,J).

affiche_plateau([M, B, PT, RJ1, RJ2]):-
    write('    J1'),nl,
    write('  '),afficher_sous_liste(RJ1),nl,nl,
    write('-------------------------'),nl,nl,
    afficher_marchs(M,PT,0),
    write('-------------------------'),nl,nl,
    write('--BOURSE--'),nl,
    afficher_bourse(B),nl,
    write('    J2'),nl,
    write('  '),afficher_sous_liste(RJ2),
    nl,
    nl,!.
