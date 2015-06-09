
example([
    [1,3,2],
    [4,5,7],
    [6,8,9]
]).

dimension([H|_],Dim):-length(H,Dim).

element_n(N,L,X):-nth(N,L,X).

ligne_n(N,Carre,L):-element_n(N,Carre,L).

colonne_n(N,[L|Q],[EN|Reste]):-element_n(N,L,EN),colonne_n(N,Q,Reste).

colonnes(Dim, Carre, [Cs]):-dimension(Carre, Dim),!, colonne_n(Dim, Carre, Cs).
colonnes(I, Carre, [C|Reste]):-colonne_n(I, Carre, C), J is I+1, colonnes(J, Carre, Reste).

colonnes(Carre,Cs):-colonnes(0,Carre,Cs).

diagonale1(_,[],[]).
diagonale1(I,[T|Q],[E|Reste]):-
    element_n(I, T,E)
    J is I+1,
    diagonale1(J,Q,Reste).
diagonale1(Carre, D1):-diagonale1(1,Carre, D1).

diagonale2(_,[],[]).
diagonale2(I,[T|Q],[E|Reste]):-
    element_n(I, T,E)
    J is I-1,
    diagonale2(J,Q,Reste).
diagonale2(Carre, D1):-dimension(Carre,Dim),diagonale2(Dim,Carre, D1).

composantes(Carre, Comp):-TODOs.

meme_somme([],_).
meme_somme([[],|Q],S):-meme_somme(T,S),meme_somme(Q,S).

magique(Carre):-composante(Carre,Q),meme_somme(Q,S).

genere_liste(UB, UB, [UB]):-!.
genere_liste(I,UB,L):-genere_liste(1, UB, L).
genere_liste(UB, L):-genere_liste(1,UB,L).

retire_el([],_,[]).
retire_el([])

genere_carre(_,[],[]).
genere_carre()

solve(N,C):-genere_carre(N,C),magique(C).