%Variables globales
gBourseInitial([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).
gAllMarchandises([
	ble,ble,ble,ble,ble,ble,ble,
	riz,riz,riz,riz,riz,riz,
	cacao,cacao,cacao,cacao,cacao,cacao,
	cafe,cafe,cafe,cafe,cafe,cafe,
	sucre,sucre,sucre,sucre,sucre,sucre,
	mais,mais,mais,mais,mais,mais
]).

%Récupère un élément aléatoire dans une liste
%random_el(+Liste,?Element)
random_el(L,N) :-
	length(L,Length),
	random(1,Length,N)
.

%Récupère un élément aléatoire et le supprime de la liste
%take_random(+Liste,?Element,?NewListe)
take_random(All,El,NewAll):-
	random_el(All,N),
	nth(N,All,El),
	select(El,All,NewAll)
.

%Retourne 4 élement aléatoire et les supprime d'une liste
%slice(+Liste,?ListeElement, ?NewListe)
slice(All, [A,B,C,D], NewAll):-
	take_random(All,A,NewAll_A),
	take_random(NewAll_A,B,NewAll_B),
	take_random(NewAll_B,C,NewAll_C),
	take_random(NewAll_C,D,NewAll)
.

%Génère toutes les marchandises
%march_init(?Marchandises)
march_init([A,B,C,D,E,F,G,H,I]) :-
	gAllMarchandises(All),
	slice(All, A, All_B),
	slice(All_B, B, All_C),
	slice(All_C, C, All_D),
	slice(All_D, D, All_E),
	slice(All_E, E, All_F),
	slice(All_F, F, All_G),
	slice(All_G, G, All_H),
	slice(All_H, H, All_I),
	slice(All_I, I, _),!
.

%%% Génération du trader %%%
%Génère la position du trader en début de partie
%gen_trader(?Position)
gen_trader(X) :-
	random(1,9,X)
.

%%% Génération du plateau %%%
%Retourne la structure plateau initialisée M, B, PT, RJ1, RJ
%plateau_depart(?Plateau)
plateau_depart([March,Bourse,Trader,[],[]]) :-
	march_init(March),
	gBourseInitial(Bourse),
	gen_trader(Trader)
.
