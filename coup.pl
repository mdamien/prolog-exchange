%%%%%%%%%%%%%%%%%% Calcul de coups %%%%%%%%%%%%%%%%%%
%coup_possible(+Plateau,?Coup)
coup_possible([M, _, P, _, _], [_,D,Keep,Drop]) :-
    D > 0, D < 4,
    bouger_trader(M,P,D,NewT),
    choix(M,NewT,Keep,Drop),
    !.

coup_possible([M, _, P, _, _], [_,D,Keep,Drop]) :-
	D > 0, D < 4,
    bouger_trader(M,P,D,NewT),
    choix(M,NewT,Drop,Keep).

%coups_possibles(+Plateau, ?ListeCoups)
coups_possibles([M, B, P, RJ1, RJ2], [C1,C2,C3,C4,C5,C6]) :-
	coup_possible([M, B, P, RJ1, RJ2],[_,1,O1,O2]),
	C1 = [_,1,O1,O2],
	C2 = [_,1,O2,O1],
	coup_possible([M, B, P, RJ1, RJ2],[_,2,O3,O4]),
	C3 = [_,2,O3,O4],
	C4 = [_,2,O4,O3],	
	coup_possible([M, B, P, RJ1, RJ2],[_,3,O5,O6]),
	C5 = [_,3,O5,O6],
	C6 = [_,3,O6,O5].

%%%%%%%%%%%%%%%%%% Jouer un coup %%%%%%%%%%%%%%%%%%
%jouer_coup(+PlateauInitial, +Coup, ?NouveauPlateau)
%Le coup qui est passé en entrée doit être valide.
jouer_coup([March,Bourse,Trader,J1,J2],[J,Move,Keep,Drop],[NMarch,NBourse,NTrader,NJ1,NJ2]) :-
	bouger_trader(March,Trader,Move,NTrader),
	add_to_player(Keep,J,J1,J2,NJ1,NJ2),
	remove_items(March,NTrader,NMarch),
	downgrade(Bourse,Drop,NBourse).	

%%%%%%%%%%%%%%%%%% Mouvement du trader %%%%%%%%%%%%%%%%%%
%bouger_trader(+Marchandises,+AncienTrader,+Deplacement,?NouveauTrader)
bouger_trader(March,OldT,Move,NewT) :-
	X is OldT+Move,
	length(March,L),
	overflow(X,L,R),
	NewT is R.

%%%%%%%%%%%%%%%%%% Ajouter une marchandise à un joueur %%%%%%%%%%%%%%%%%%
%add_to_player(+Objet,+Joueur,+Reserve1,+Reserve2)
add_to_player(Keep,J,J1,J2,NJ1,NJ2) :-
	J == 'j1',
	NJ1 = [Keep|J1],
	NJ2 = J2,
	!.

add_to_player(Keep,J,J1,J2,NJ1,NJ2) :-
	J == 'j2',
	NJ2 = [Keep|J2],
	NJ1 = J1.

%%%%%%%%%%%%%%%%%% Retrait des 2 items %%%%%%%%%%%%%%%%%%
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
%Retire l'élément en haut de la pile indiquée par Position
remove([H|T],1,R) :-
	remove_top(H,X),
	concat([X],T,R),
	!.
remove([H|T],Pos,NMarch) :-
	NPos is Pos-1,
	remove(T,NPos,R),
	concat([H],R,NMarch),
	!.
%Retire le premier élément d'une liste
remove_top([_|T],T).

%%%%%%%%%%%%%%%%%% Dévaluation %%%%%%%%%%%%%%%%%%
%downgrade(Bourse,Drop,NBourse)
downgrade([[Drop|Val]|T],Drop,[[Drop,NVal]|T]) :-
	Val>0, %Voir si ça marche bien quand un produit est à zéro
	NVal is Val-1,
	!.

downgrade([H|T],Drop,R) :-
	downgrade(T,Drop,Tmp),
	concat([H],Tmp,R),
	!.

%%%%%%%%%%%%%%%%%% Tools %%%%%%%%%%%%%%%%%%
%overflow(+Position,+LongueurPlateau,?PositionModuloLongueur)
overflow(X,L,R) :- 
	Y is X-L, 
	Y>0,
	overflow(Y,L,R),
	!.
overflow(X,_,R) :-
	R is X.

%Supprime une sous-liste lorsque celle-ci est vide
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
backflow(X,_,X).

concat([],L,L).
concat([H|T],L,[H|X]):- concat(T,L,X).

len([],0).
len([_|T],N):-len(T,N2),N is N2 + 1.
%%%%%%%% Pour les tests %%%%%%%%
%jouer_coup([[[ble,riz],[mais,cacao,sucre],[cafe,mais],[riz],[sucre,mais,cafe,cacao]],[[ble,7],[riz,6],[cacao,5],[cafe,6],[sucre,6],[mais,6]],3,[ble,ble,cacao],[sucre,cacao,mais]],[j1,2,ble,riz],[M,B,T,J1,J2]).
