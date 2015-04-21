appart([H|_], H):-!.
appart([_|T], X):- appart(T, X).

conc([],L,L).
conc([H|T],L,[H|X]):- conc(T,L,X).

long([],0).
long([_|T],N):-long(T,Y), N is Y+1.

elem([H|_],1,H).
elem([_|T],N,E):-Im is N-1,elem(T,X,E).