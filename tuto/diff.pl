non(X):-X,!,fail. 
non(_).

diff(X,X):-!, fail.
diff(X,Y).