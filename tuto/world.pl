fact(0, 1).
fact(N, F) :- T is N-1, fact(T,R), F is N*R.