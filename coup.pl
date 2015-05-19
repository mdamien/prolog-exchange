%coup_possible(+Plateau,?Coup)
coup_possible(P,[J,Move,Keep,Drop]).


%jouer_coup(+PlateauInitial, ?Coup, ?NouveauPlateau)
jouer_coup([March,Bourse,Trader,J1,J2],[J,Move,Keep,Drop],[NMarch,NBourse,NTrader,NJ1,NJ2]) :-
	%appart([NPos
	NJ1 is J1,	
	NJ2 is J2,
	NTrader = Trader+Move, %Il faut le faire revenir au début si ça déborde

	add(Old,Keep,New).	

%ajoute
add(Old,Keep,[Keep|Old]).

%cherche
appart([H|_], H):-!.
appart([_|T], X):- appart(T, X).
