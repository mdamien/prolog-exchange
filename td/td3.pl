gGraphe([(1,2),(1,6),(2,3),(2,4),(3,4),(4,5),(5,1)]).

succ(X,Y,[(X,Y)|_]).
succ(X,Y,[(_,_)|T]):-succ(X,Y,T).

degre(_,0,[]).
degre(X,D,[(X,_)|T]):-degre(X,D2,T),D is D2+1,!.
degre(X,D,[(_,X)|T]):-degre(X,D2,T),D is D2+1,!.
degre(X,D,[(_,_)|T]):-degre(X,D,T).

%%utils!
in(X,[X|_]):-!.
in(X,[_|T]):-in(X,T).

set_add(X,L,L):-in(X,L),!.
set_add(X,L,[X|L]).
%%end utils

sommets([],[]).
sommets(E,[(X,Y)|T]):-
    sommets(E1,T),
    set_add(X,E1,E2),
    set_add(Y,E2,E).

chemin(Y,Y,_):-!.
chemin(X,Y,G):-succ(X,Xsucc,G),chemin(Xsucc,Y,G).

chemin(Y,Y,_,[Y]).
chemin(X,Y,G,[X|C]):-
    succ(X,Xsucc,G),
    chemin(Xsucc,Y,G,C).

%util
remove(X,[X|T],T):-!.
remove(X,[H|T],[H|NT]):-remove(X,T,NT).

chemin2(Y,Y,_,[Y]).
chemin2(X,Y,G,[X|C]):-
    succ(X,Xsucc,G),
    remove((X,Xsucc),G,NG),
    chemin(Xsucc,Y,NG,C).

circuit(G):-chemin(X,X,G).

not_in(_,[]).
not_in(X,[_|T]):-not_in(X,T).

elementaire([X|T]):-not_in(X,T),elementaire(T).

%ou elementaire([X|T]):-\+in(X,T),elementaire(T).


gGrapheV([(1,2,1),(1,6,2),(2,3,1),
    (2,4,5),(3,4,2),(4,5,5),(5,1,2)]).

succV(X,Y,V,[(X,Y,V)|_]).
succV(X,Y,V,[(_,_,_)|T]):-succV(X,Y,V,T).

cheminV(Y,Y,_,[Y],0).
cheminV(X,Y,G,[X|C],V):-
    succV(X,Xsucc,Vsucc,G),
    remove((X,Xsucc,Vsucc),G,NG),
    cheminV(Xsucc,Y,NG,C,Vc),
    V is Vsucc + Vc.

un_plus_court(X,Y,G,V):-
    cheminV(X,Y,G,_,V2),
    V2 < V.

pcc(X,Y,G,C,V):-
    cheminV(X,Y,G,C,V),
    \+un_plus_court(X,Y,G,V).