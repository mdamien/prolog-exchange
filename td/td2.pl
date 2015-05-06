tete(H,[H|_]).
queue(T,[_|T]).
vide([]).

imprime([X]):-write(X),nl.
imprime([H|T]):-write(H),write(','),imprime(T).

element(X,[X|_]).
element(X,[_|T]):-element(X,T).

dernier(X,[X]).
dernier(X,[_|T]):-dernier(X,T).

longueur(0,[]).
longueur(Long,[_|T]):-longueur(N,T),Long is N+1.

nombre(_,[],0):-!.
nombre(X,[X|T],NB):-nombre(X,T,NB2),NB is NB2+1.
nombre(X,[_|T],NB):-nombre(X,T,NB).

concat([],L,L).
concat([H|T],L,[H|X]):- concat(T,L,X).

inverse([],[]).
inverse([H|T],L):-inverse(T,I),concat(I,[H],L).

infs(_,[],[]):-!.
infs(X,[H|T],[H|R2]):-H =< X,infs(X,T,R2).
infs(X,[H|T],R):-H > X,infs(X,T,R).

sups(_,[],[]):-!.
sups(X,[H|T],[H|R2]):-H > X,sups(X,T,R2).
sups(X,[H|T],R):-H =< X,sups(X,T,R).

partition(X,L,Inf,Sup):-
    sups(X,L,Sup),infs(X,L,Inf).


partition2(_,[],[],[]).
partition2(X,[T|Q],[T|L1],L2):-T =< X, partition2(X,Q,L1,L2).
partition2(X,[T|Q],L1,[T|L2]):-T > X, partition2(X,Q,L1,L2).

tri([],[]).
tri([H|L],R):-
    write('tri: pivot='),
        write(H),write(' L='),write(L),nl,
    partition2(H,L,Inf,Sup),
    tri(Inf,InfTriee),
    tri(Sup,SupTriee),
    concat(InfTriee,[H|InfPlusX]).