%gprolog --init-goal "[affichage],gPlateauTest(Y),affiche_plateau(Y),halt"
gPlateauTest([
    [[mais,ble],[ble,sucre]],[[mais,1],[ble,2]],
    [1,9],[ble,ble],[sucre,sucre]]).

bold(S):-
    write('\33\[1m'),write(S),write('\33\[0m').

underline(S):-
    write('\33\[4m'),write(S),write('\33\[0m').

italic(S):-
    write('\33\[3m'),write(S),write('\33\[0m').

red(S):-
    write('\33\[31m'),write(S),write('\33\[0m').

green(S):-
    write('\33\[32m'),write(S),write('\33\[0m').

afficher_sous_liste([]):-write('vide').
afficher_sous_liste([H|[]]):-write(H).
afficher_sous_liste([H|T]):-write(H),write(','),afficher_sous_liste(T).

afficher_liste([]).
afficher_liste([H|T]):-afficher_sous_liste(H),nl,afficher_liste(T).

afficher_val_bourse([P,V]):-write(P),write(' '),green(V).

afficher_bourse([]).
afficher_bourse([H|T]):-afficher_val_bourse(H),write(','),afficher_bourse(T).

afficher_pos(X,P,P):-bold(X),bold('(T)').
afficher_pos(X,_,_):-italic(X).

afficher_marchs([],_,_):-!.
afficher_marchs([[H1|_]|T],P,I):-
    afficher_pos(H1,P,I),
    write(' '),J is I+1,afficher_marchs(T,P,J).

affiche_plateau([M, B, PT, RJ1, RJ2]):-
    %write('MMM:'),write(M),nl,
    %write('BBB:'),write(B),nl,
    %write('PT:'),write(PT),nl,
    italic('TAS: '),
    afficher_marchs(M,PT,1),nl,
    italic('BOURSE: '),
    afficher_bourse(B),nl,
    score(RJ1, B, ScoreJ1),
    score(RJ2, B, ScoreJ2),
    italic('Réserve J1: '),afficher_sous_liste(RJ1),write(' - Score: '),green(ScoreJ1),nl,
    italic('Réserve J2: '),afficher_sous_liste(RJ2),write(' - Score: '),green(ScoreJ2),nl,
    nl,!.
