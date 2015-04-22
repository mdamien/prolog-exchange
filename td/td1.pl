homme(pierre).
homme(georges).
homme(damien).
homme(toto).
homme(paul).
homme(maxime).
homme(jacques).
homme(jules).
homme(bertrand).
homme(antoine).

femme(eve).
femme(pauline).
femme(jeanne).
femme(nicole).
femme(sandra).
femme(marine).

union(jacques,nicole).
union(marine,paul).
couple(jules,sandra).

parent(pierre,georges).
parent(jeanne,georges).
parent(eve,damien).
parent(georges,damien).
parent(pauline,toto).
parent(paul,maxime).
parent(marine,maxime).
parent(marine,antoine).
parent(bertrand,antoine).
parent(jacques,marine).
parent(nicole,marine).
parent(marine,jules).
parent(paul,jules).

pere(X,Y):-homme(X),parent(X,Y).
femme(X,Y):-femme(X),parent(X,Y).

%cloture symetrique de union
mariage(X,Y):-union(Y,X).
mariage(X,Y):-union(X,Y).

ensemble(X,Y):-mariage(X,Y).
ensemble(X,Y):-couple(X,Y).
ensemble(X,Y):-couple(Y,X).

epoux(X,Y):-homme(X),mariage(X,Y).
epouse(X,Y):-femme(X),mariage(X,Y).

fils(X,Y):-homme(X),parent(Y,X).
fille(X,Y):-femme(X),parent(Y,X).

enfant(X,Y):-parent(Y,X).

grandParent(X,Y):-parent(X,Z),parent(Z,Y).
grandPere(X,Y):-homme(X),grandParent(X,Y).
grandMere(X,Y):-femme(X),grandParent(X,Y).

petitFils(X,Y):-homme(X),grandParent(Y,X).
petitFils(X,Y):-homme(X),grandParent(Y,X).

memePere(X,Y):-pere(Z,X),pere(Z,Y).
memeMere(X,Y):-mere(Z,X),mere(Z,Y).

auMoinsUnMemeParent(X,Y):-parent(Z,X),parent(Z,Y).

unSeulMemeParent(X,Y):-auMoinsUnMemeParent(X,Y),\+memeParents(X,Y).

memeParents(X,Y):-memeMere(X,Y),memePere(X,Y). 

soeur(X,Y):-femme(X),memeParents(X,Y). %x != Y, but don't work in prolog...
frere(X,Y):-homme(X),memeParents(X,Y).

demiFrere(X,Y):-homme(X),homme(Y),unSeulMemeParent(X,Y).
demiSoeur(X,Y):-femme(X),femme(Y),unSeulMemeParent(X,Y).

oncle(X,Y):-parent(Y,Z),frere(X,Z).
oncle(X,Y):-parent(Y,Z),memeParents(Z,W),epoux(X,W). %demi oncles ?
tante(X,Y):-parent(Y,Z),soeur(X,Z).
tante(X,Y):-parent(Y,Z),memeParents(Z,W),epoux(X,W).

oncle_ou_tante(X,Y):-oncle(X,Y).
oncle_ou_tante(X,Y):-stante(X,Y).

neveu(X,Y):-homme(X),oncle_ou_tante(X,Y).
niece(X,Y):-femme(X),oncle_ou_tante(X,Y).

cousin(X,Y):-homme(X),oncle_ou_tante(X,Z),oncle_ou_tante(Y,Z).
cousine(X,Y):-femme(X),oncle_ou_tante(X,Z),oncle_ou_tante(Y,Z).

gendre(X,Y):-homme(X),parent(Y,Z),ensemble(X,Z).
bru(X,Y):-femme(X),parent(Y,Z),ensemble(X,Z).

belle_mere(X,Y):-parent(Z,Y),mariage(Z,X),femme(X),mere(X,Y). %deux sens
belle_mere(X,Y):-mere(X,Z),mariage(Z,Y).

ascendant(X,Y):-parent(X,Y).
ascendant(X,Y):-parent(Z,Y),ascendant(X,Z).

descendant(X,Y):-ascendant(Y,X).

lignee(X,Y):-ascendant(Y,X).
lignee(X,Y):-descendant(Y,X).
lignee(X,Y):-X=Y.

parente(X,Y):-ascendant(X,Y).