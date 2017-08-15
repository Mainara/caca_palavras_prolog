desenhaLinha([P1, P2, P3]) :-
	write(P1),
	write(' '),
	write(P2),
	write(' '),
	write(P3),
	write(' '),
	nl.

desenhaMatriz([X, Y, Z]) :-
	nl, 
	desenhaLinha(X),
		 nl,

	desenhaLinha(Y),
		 nl,

	desenhaLinha(Z),

	nl.	



matriz([['a', 'b', 'c'], ['d', 'e', 'f'], ['g', 'h', 'i']]).


:- initialization main.

main :-
	matriz(Matriz),
	desenhaMatriz(Matriz), nl.
	

























