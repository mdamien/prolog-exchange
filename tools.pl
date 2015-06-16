%Retourne les sommets des deux piles autour du joueur
%choix(+Marchandises,+PositionTrader,?ItemAGauche, ?ItemADroite)
choix(M,Trader,Choix1, Choix2):-
	length(M, L),
	T1 is Trader-1,
   backflow(T1,L,P1),
	T2 is Trader+1,
   overflow(T2,L,P2),
   top_pile(P1, M, Choix1),
   top_pile(P2, M, Choix2)
.

%Retourne le premier élément de la liste à la position donnée
%top_pile(+Index,+ListeMarchandises,?Element)
top_pile(Index,M,Top):-
    nth(Index,M,[Top|_])
.

%Supprime le premier élément vide dans une liste
%remove_empty_items(+ListeEntrée,?ListeSortie)
remove_empty_items(In,Out):-
   select([],In,Out);Out = In %Select récupère le premier élement d'une ligne étant une liste vide, et le retire
.

%Récupère une position et une longueur. Si la position > longueur, il retourne une position valide correspondant au dépassement
%overflow(+Position,+LongueurPlateau,?PositionModuloLongueur)
overflow(X,L,R) :-
	Y is X-L,
	Y>0,
	overflow(Y,L,R),
	!
.
overflow(R,_,R).

%Récupère une position et une longueur. Si la position < 0, il retourne une position valide correspondant à la valeur de dépassement négative, en partant du bout de liste
%backflow(+Position,+LongueurPlateau,?PositionModuloLongueur)
backflow(X,L,Y) :-
	X=<0,
	Y is L,
	!
.
backflow(X,_,X).

%Concatene 2 listes et retourne le résultat dans une troisième
%concat(+L1,+L2,?L1L2)
concat([],L,L).
concat([H|T],L,[H|X]):-
	concat(T,L,X)
.

%Retourne la valeur en bourse d'un élément
%bourse_val(+Bourse,+Element,?Valeur)
bourse_val([[K,V]|_], K, V):- !.
bourse_val([_|T], K, V):-
	bourse_val(T, K, V)
.

%Vérifie que le jeu est fini ou non (regarde le nombre de pile restante)
%fin_jeu(+Marchandises)
fin_jeu(M) :-
	length(M,L),
	L < 3
.

%Calcul le score d'un joueur
%score(+ReserveJoueur,+Bourse,?Score)
score([], _, 0).
score([H|T], Bourse, Points):-
	bourse_val(Bourse, H, Pts),
	score(T, Bourse, AutresPts),
	Points is (Pts + AutresPts)
.
