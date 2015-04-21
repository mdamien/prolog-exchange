%affiche_plateau(+Plateau)
%affiche_plateau([[1,2], [1,2],[],[],[]]).

%gprolog --init-goal "[projet],affiche_plateau([[1,2], [1,2],[],[],[]]),halt"

affiche_plateau([Marchandises, Bourse, 
        PositionTrader,ReserveJoueur1,ReserveJoueur2]):-write('plateau yeah'),nl.