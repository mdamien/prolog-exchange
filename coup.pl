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

%%%%%%%%%%%%%%%%%% Jouer un coup %%%%%%%%%%%%%%%%%%
%jouer_coup(+PlateauInitial, ?Coup, ?NouveauPlateau)
jouer_coup([March,Bourse,Trader,J1,J2],[J,Move,Keep,Drop],[NMarch,NBourse,NTrader,NJ1,NJ2]) :-
	bouger_trader(March,Trader,Move,NTrader),
	add_to_player(Keep,J,J1,J2,NJ1,NJ2),
	remove_items(March,NTrader,NMarch),
	downgrade(Bourse,Drop,NBourse).	

%%%%%% Mouvement du trader %%%%%%
%bouger_trader(+Marchandises,+AncienTrader,+Deplacement,?NouveauTrader)
bouger_trader(March,OldT,Move,NewT) :-
	X is OldT+Move,
	length(March,L),
	%X is X-L,
	overflow(X,L,R),
	NewT is R.

%overflow(+Position,+LongueurPlateau,?PositionModuloLongueur)
overflow(X,L,R) :- 
	Y is X-L, 
	Y>0,
	%R is Y,
	overflow(Y,L,R),
	!.
overflow(X,L,R) :-
	R is X.

%%%%%% Ajouter une marchandise à un joueur %%%%%%
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

%%%%%% Retrait des 2 items de la liste Marchandise %%%%%%
%remove_items(+Marchandises,+NewPosTrader,?NewMarchandises)
remove_items(March,Trader,NMarch) :-
	length(March,L),
	TPos1 is Trader-1,
	backflow(TPos1,L,Pos1),
	TPos2 is Trader+1,
	overflow(TPos2,L,Pos2),
	remove(March,Pos1,TmpMarch),
	remove(TmpMarch,Pos2,TmpMarch2),
	clear_empty(TmpMarch2,NMarch).

%remove(Marchandises,Position,NewMarchandises)
remove([H|T],1,R) :-
	remove_top(H,X),
	concat([X],T,R),
	!.
remove([H|T],Pos,NMarch) :-
	NPos is Pos-1,
	remove(T,NPos,R),
	concat([H],R,NMarch),
	!.
remove_top([H|T],T).

clear_empty([[]|T],T).
clear_empty([],[]).
clear_empty([H|T],NMarch) :-
	clear_empty(T,R),
	concat([H],R,NMarch),
	!.

backflow(X,L,Y) :-
	X=<0,
	Y is L,
	!.
backflow(X,L,X).

concat([],L,L).
concat([H|T],L,[H|X]):- concat(T,L,X).


%%%%%% Dévaluation %%%%%%
%downgrade(Bourse,Drop,NBourse)
downgrade([[Drop|Val]|T],Drop,[[Drop,NVal]|T]) :-
	Val>0, %Voir si ça marche bien quand un produit est à zéro
	NVal is Val-1,
	!.
downgrade([H|T],Drop,R) :-
	downgrade(T,Drop,Tmp),
	concat([H],Tmp,R),
	!.


%%%%%%%% Pour les tests %%%%%%%%
%jouer_coup([[[ble,riz],[mais,cacao,sucre],[cafe,mais],[riz],[sucre,mais,cafe,cacao]],[[ble,7],[riz,6],[cacao,5],[cafe,6],[sucre,6],[mais,6]],3,[ble,ble,cacao],[sucre,cacao,mais]],[j1,2,ble,riz],[M,B,T,J1,J2]).
