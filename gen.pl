%Prochain TP le 19-05 puis 02-06 puis le 16-06

%gprolog --init-goal "[gen],[affichage],depart_plateau(Y),write(Y),nl,affiche_plateau(Y),halt"

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

random_el(L,N) :-
	length(L,Length),
	random(1,Length,N).

%take random element and remove it
take_random(All,El,NewAll):-
	random_el(All,N),
	nth(N,All,El),
	select(El,All,NewAll)
.

%return 4 four random and remove them
slice(All, [A,B,C,D], NewAll):-
	take_random(All,A,NewAll_A),
	take_random(NewAll_A,B,NewAll_B),
	take_random(NewAll_B,C,NewAll_C),
	take_random(NewAll_C,D,NewAll).

%march_init(?Marchandises)
%Génère toutes les marchandises
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
	slice(All_I, I, _),!.

%%% Génération du trader %%%
%gen_trader(?Position)
%Génère la position du trader en début de partie
gen_trader(X) :-
	random(1,9,X).

%%% Génération du plateau %%%
%gen_plateau(?Plateau)
%Retourne la structure plateau initialisée M, B, PT, RJ1, RJ2
plateau_depart([March,Bourse,Trader,[],[]]) :-
	%user_time(TS),
	%set_seed(TS),
	march_init(March),
	gBourseInitial(Bourse),
	gen_trader(Trader).