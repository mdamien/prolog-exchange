flatten([],[]).
flatten([T|Q],R):-
	flatten(T,TF),!,
	flatten(Q,QF),
	append(TF,QF,R).
flatten([T|Q],[T|R]):-
	flatten(Q,R).

element(X,[X|_],1).
element(X,[_|Q],N):-
	element(X,Q,N1),
	N is N1+1.

base1([0,1,2,3,4,5,6,7,8,9]).
base2([toto,titi,rouge]).

inverse([],L,L).
inverse([T|Q],L,R):-inverse(Q,[T|L],R).
inverse(L,R):-inverse(L,[],R).

succ(CB,[T|Q],[ST|Q]):-
	element(T,B,N),
	M is N+1,
	element(ST,B,M),!.
	
succ(B,[_|Q],[ST|SQ]):-
	succ(B,Q,SQ),
	element(ST,B,1).

succ(B,[],[D]):-element(D,B,2).

succ(B,N,R):-
	inverse(N,N1),
	succ(B,N1,N2),
	inverse(N2,R).

%fermier	-> f
%loup	-> l
%chevre	-> c
%salade	-> s
%rien	-> r

etat_init([[f,l,c,s],[r,r,r,r]]).
etat_final([[r,r,r,r],[f,l,c,s]]).


move([[f,l,B,C],[r,r,E,F]],loup_G_D,[[r,r,B,C],[f,l,E,F]]).
move([[f,B,c,C],[r,E,c,F]],chevre_G_D,[[r,B,r,C],[f,E,c,F]]).
move([[f,B,C,s],[r,E,F,s]],salade_G_D,[[r,B,C,r],[f,E,F,s]]).
move([[f,B,C,D],[r,E,F,H]],rien_G_D,[[r,B,C,D],[f,E,F,H]]).

move([[r,r,B,C],[f,l,E,F]],loup_D_G,[[f,l,B,C],[r,r,E,F]]).
move([[r,B,r,C],[f,E,c,F]],chevre_D_G,[[f,B,c,C],[r,E,c,F]]).
move([[r,B,C,r],[f,E,F,s]],salade_D_G,[[f,B,C,s],[r,E,F,s]]).
move([[r,B,C,D],[f,E,F,H]],rien_D_G,[[f,B,C,D],[r,E,F,H]]).

pas_valide([r,l,c,_]).
pas_valide([r,_,c,s]).

valide([G,D]):-
	\+pas_valide(G),
	\+pas_valide(D).

solve(E,E,_,[]).
solve(E,EF,H,[Mvt|Mvts]):-
	move(E,Mvt,ESucc),
	valide(ESucc),
	\+element(ESucc,H),
	solve(ESucc,EF,[ESucc|H],Mvts).

start(R):-
	etat_init(EI),
	etat_final(EF),
	solve(EI,EF,[],R).





