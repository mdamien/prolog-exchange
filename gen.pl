%Variables globales
min(0).
max(6).

%gen_bourse(?Bourse)
fBourseChoix([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).

%gen_march(?Marchandises)

%gen_pile(?Pile)
%gen_pile([A,B,C,D]) :- random(

%gen_elem(?Element)
%gen_elem(X) :- random(1,6,Y).

gen_bourse_one(_,0,R).
gen_bourse_one([Type,Limit],N,-R):-
    write(Type),write(' :'),
    random(0,Limit,Q),write(Q),nl,
    Nm is N-1,
    gen_bourse_one([Type,Limit],Nm,-R).

gen_bourse([],X).
gen_bourse([H|T],X):-gen_bourse_one(H,R),gen_bourse(T,[R|X]).