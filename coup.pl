len([],0).
len([_|T],N):-len(T,N2),N is N2 + 1.

%coup_possible(+Plateau,?Coup)

coup_possible([M, B, P, RJ1, RJ2], [J,D,Keep,Drop]):-
    write('D'),write(D),nl,
    D > 0, D < 4,
    write('D ok'),nl,
    NextPTFull = P+D,
    write('new PT'),write(NextPT),nl,
    len(M,Mlen),write(Mlen),nl,
    NextPT = NextPTFull mod Mlen,
    write(Mlen),nl,
    write('deplacement ok'),nl.


%jouer_coup(+PlateauInitial, ?Coup, ?NouveauPlateau)
jouer_coup([March,Bourse,Trader,J1,J2],[J,Move,Keep,Drop],[NMarch,NBourse,NTrader,NJ1,NJ2]) :-
	NJ1 is J1,	
	NJ2 is J2,
	bouger_trader(March,Trader,Move,NTrader),
	add_to_player(Keep,J,J1,J2,NJ1,NJ2),
	add(Old,Keep,New).	

%bouger_trader(+Marchandises,+AncienTrader,+Deplacement,?NouveauTrader)
bouger_trader(March,OldT,Move,NewT) :-
	X is OldT+Move,
	length(March,L),
	%X is X-L,
	overflow(X,L,R),
	NewT is R.

overflow(X,L,R) :- 
	Y is X-L, 
	Y>0,
	%R is Y,
	overflow(Y,L,R),
	!.

overflow(X,L,R) :-
	R is X.

%add_to_player(+Objet,+Joueur,+Reserve1,+Reserve2)
add_to_player(Keep,J,J1,J2,NJ1,NJ2) :-
	J == "j1",
	NJ1 = [Keep|J1],
	NJ2 = J2,
	!.

add_to_player(Keep,J,J1,J2,NJ1,NJ2) :-
	J == "j2",
	NJ2 = [Keep|J2],
	NJ1 = J1.

%ajoute
add(Old,Keep,[Keep|Old]).

%cherche
appart([H|_], H):-!.
appart([_|T], X):- appart(T, X).

%gprolog --init-goal "[gen],[affichage],[coup],plateau_depart(P),nl,affiche_plateau(P),coup(P,[j1,2,cafe,cacao]),halt"
