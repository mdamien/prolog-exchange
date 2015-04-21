concat([],B,R):B is R,-L,!.
concat([X:A], B, R):-R is [X:B], concat(A, B, R).