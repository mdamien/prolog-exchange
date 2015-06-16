%%%%%%%%%%%%%%%%%% Calcul de coups %%%%%%%%%%%%%%%%%%
%Vérifie qu'un coup respecte les règles du jeu
%coup_possible(+Plateau,?Coup)
coup_possible([M, _, P, _, _], [_,D,Keep,Drop]) :-
    D > 0, D < 4,                   %Check de la valeur du déplacement
    bouger_trader(M,P,D,NewT),      %On déplace le trader
    choix(M,NewT,Keep,Drop),        %On vérifie les choix
    !
.

%Retourne la liste des coups autorisés en fonction de l'état du plateau
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
	C6 = [_,3,O6,O5]
.

%%%%%%%%%%%%%%%%%% Jouer un coup %%%%%%%%%%%%%%%%%%
%Joue un coup et retourne le nouvel état du plateau
%Le coup qui est passé en entrée DOIT ÊTRE VALIDE !
%jouer_coup(+PlateauInitial, +Coup, ?NouveauPlateau)
jouer_coup([March,Bourse,Trader,J1,J2],[J,Move,Keep,Drop],[NMarch,NBourse,NTrader,NJ1,NJ2]) :-
	bouger_trader(March,Trader,Move,TmpTrader),
	add_to_player(Keep,J,J1,J2,NJ1,NJ2),
	remove_items(March,TmpTrader,NMarchPlusVide),
	remove_empty_items(NMarchPlusVide,NMarchPlusVide2),
	remove_empty_items(NMarchPlusVide2,NMarch),
   bouger_trader(NMarch,TmpTrader,0,NTrader),  %Pour que le trader soit à une position valide si une pile a disparue
	downgrade(Bourse,Drop,NBourse),!
.

%%%%%%%%%%%%%%%%%% Mouvement du trader %%%%%%%%%%%%%%%%%%
%Déplace le trader et retourne le nouvel emplacement du trader.
%Gère le cas où le trader dépasse le nombre de pile.
%bouger_trader(+Marchandises,+AncienTrader,+Deplacement,?NouveauTrader)
bouger_trader(March,OldT,Move,NewT) :-
	X is OldT+Move,
	length(March,L),
	overflow(X,L,R),
	NewT is R
.

%%%%%%%%%%%%%%%%%% Ajouter une marchandise à un joueur %%%%%%%%%%%%%%%%%%
%Ajoute la marchandise passée en paramètre dans la bonne réserve du joueur
%add_to_player(+Objet,+Joueur,+Reserve1,+Reserve2,?NewReserve1, ?NewReserve2)
add_to_player(Keep,J,J1,J2,NJ1,NJ2) :-
	J == 'j1', %Si c'est le joueur 1
	NJ1 = [Keep|J1],
	NJ2 = J2,
	!
.
add_to_player(Keep,J,J1,J2,NJ1,NJ2) :-
	J == 'j2', %Si c'est le joueur 2
	NJ2 = [Keep|J2],
	NJ1 = J1
.

%%%%%%%%%%%%%%%%%% Retrait des 2 items %%%%%%%%%%%%%%%%%%
%Supprime les éléments en haut des piles autour du trader
%remove_items(+Marchandises,+NewPosTrader,?NewMarchandises)
remove_items(March,Trader,NMarch) :-
	length(March,L),
	TPos1 is Trader-1,
	backflow(TPos1,L,Pos1),
	TPos2 is Trader+1,
	overflow(TPos2,L,Pos2),
	remove(March,Pos1,TmpMarch),
	remove(TmpMarch,Pos2,NMarch)
.

%Retire l'élément en haut de la pile indiquée par Position
%remove(+Marchandises,+Position,?NewMarchandises)
remove([H|T],1,R) :-
	remove_top(H,X),
	concat([X],T,R),
	!
.
remove([H|T],Pos,NMarch) :-
	NPos is Pos-1,
	remove(T,NPos,R),
	concat([H],R,NMarch),
	!
.

%Retire le premier élément d'une liste
%remove_top(+Liste,?ListeMoinsTete)
remove_top([_|T],T).

%%%%%%%%%%%%%%%%%% Dévaluation %%%%%%%%%%%%%%%%%%
%Dévalue la valeur boursière d'un élément
%downgrade(+Bourse,+ElementADevalué,?NewBourse)
downgrade([[Drop|Val]|T],Drop,[[Drop,NVal]|T]) :- %Lorsque l'on a trouvé la bonne valeur
	NVal is Val-1,
	!
.
downgrade([H|T],Drop,R) :- %On parcourt la liste Bourse
	downgrade(T,Drop,Tmp),
	concat([H],Tmp,R),
	!
.
