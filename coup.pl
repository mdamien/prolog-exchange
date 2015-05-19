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

%gprolog --init-goal "[gen],[affichage],[coup],plateau_depart(P),nl,affiche_plateau(P),coup(P,[j1,2,cafe,cacao]),halt"
