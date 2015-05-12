%Prochain TP le 19-05 puis 02-06 puis le 16-06

%gprolog --init-goal "[gen],[affichage],gen_plateau(Y),write(Y),nl,affiche_plateau(Y),halt"

%Variables globales
gBourseInitial([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).

%march_init(?Marchandises)
%Génère toutes les marchandises
march_init([A,B,C,D,E,F,G,H,I]) :-
	pile_init(A),
	pile_init(B),
	pile_init(C),
	pile_init(D),
	pile_init(E),
	pile_init(F),
	pile_init(G),
	pile_init(H),
	pile_init(I).
	
%pile_init(?Pile)
%Génère une pile de 4 élements de marchandise
pile_init([A,B,C,D]) :- 
	gen_elem(A),
	gen_elem(B),
	gen_elem(C),
	gen_elem(D).

%gen_elem(?Element)
%Retourne un élément de marchandise au hasard
gen_elem(X) :- 
	elem_rand([ble,riz,cacao,cafe,sucre,mais], X).

%elem_rand(+Enum,?Elem)
%Prend une liste similaire à une énumération et retourne un élément au hasard
%On utilise la fonction elem pour obtenir le ième élément
elem([H|_],1,H).
elem([_|T],N,E):-
	X is N-1,elem(T,X,E).

elem_rand([H|T],Y) :-
	random(1,6,Num),
	elem([H|T],Num,Y).


%%% Génération du trader %%%
%gen_trader(?Position)
%Génère la position du trader en début de partie
gen_trader(X) :-
	random(1,9,X).

%%% Génération du plateau %%%
%gen_plateau(?Plateau)
%Retourne la structure plateau initialisée M, B, PT, RJ1, RJ2
gen_plateau([March,Bourse,Trader,[],[]]) :-
	march_init(March),
	gBourseInitial(Bourse),
	gen_trader(Trader).