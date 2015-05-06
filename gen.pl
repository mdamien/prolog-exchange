%Variables globales
min(0).
max(6).


%%% Génération de la bourse %%%
%fBourseInit(?Bourse)
%Génère la bourse en début de partie
fBourseInit([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).


%%% Génération des marchandises %%%
%fMarchInit(?Marchandises)
%Génère toutes les marchandises en début de partie.
fMarchInit([A,B,C,D,E,F,G,H,I]) :-
	fPileInit(A),
	fPileInit(B),
	fPileInit(C),
	fPileInit(D),
	fPileInit(E),
	fPileInit(F),
	fPileInit(G),
	fPileInit(H),
	fPileInit(I).
	
%fPileInit(?Pile)
%Génère une pile de 4 élements de marchandise
fPileInit([A,B,C,D]) :- 
	gen_elem(A),
	gen_elem(B),
	gen_elem(C),
	gen_elem(D).

%fGenElem(?Element)
%Retourne un élément de marchandise au hasard
fGenElem(X) :- 
	elemRand([ble,riz,cacao,cafe,sucre,mais], X).

%elemRand(+Enum,?Elem)
%Prend une liste similaire à une énumération et retourne un élément au hasard
%On utilise la fonction elem pour obtenir le ième élément
elem([H|_],1,H).
elem([_|T],N,E):-
	X is N-1,elem(T,X,E).

elemRand([H|T],Y) :-
	random(1,6,Num),
	elem([H|T],Num,Y).


%%% Génération du trader %%%
%fGenTrader(?Position)
%Génère la position du trader en début de partie
fGenTrader([X,9]) :-
	random(1,9,X).

%%% Génération du plateau %%%
%fGenPlateau(?Plateau)
%Retourne la structure plateau initialisée
fGenPlateau([March,Bourse,Trader,[],[]]) :-
	fMarchInit(March),
	fBourseInit(Bourse),
	fGenTrader(Trader).


%gen_bourse_one(_,0,R).
%gen_bourse_one([Type,Limit],N,-R):-
%    write(Type),write(' :'),
%    random(0,Limit,Q),write(Q),nl,
%    Nm is N-1,
%    gen_bourse_one([Type,Limit],Nm,-R).

%gen_bourse([],X).
%gen_bourse([H|T],X):-gen_bourse_one(H,R),gen_bourse(T,[R|X]).
