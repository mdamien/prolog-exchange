pere(jean,pierre).
pere(jean,jacques).
pere(pierre,paul).
pere(jacques,remi).

grandpere(X,Z) :- pere(X,Y) , pere(Y,Z).