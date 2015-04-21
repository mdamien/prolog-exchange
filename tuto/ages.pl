age(paul, 20).
age(pierre, 30).
age(julie, 15).

plus_vieux(X,Y) :- age(X,Xage),
     age(Y,Yage), Xage > Yage.