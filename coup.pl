%coup_possible(+Plateau,?Coup)

%gprolog --init-goal "[gen],[affichage],[coup],plateau_depart(P),nl,affiche_plateau(P),coup(P,[j1,2,cafe,cacao]),halt"

len([],0).
len([_|T],N):-len(T,N2),N is N2 + 1.

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