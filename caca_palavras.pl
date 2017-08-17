/**A partir de indices forma uma palavra e verifica se essa palavra esta em uma lista de palavras escodidas**/

formaPalavra([H|T],P1,S) :- 
	(P1\=="") -> x1([H|T],P1,S); x1([H|T],"",S).
	
x1([H|T],P1,S) :-
	leIndices(LI,COL),
	procuraletra([H|T],LI,COL,LETRA),
	string_concat(P1,LETRA,X),
	continuar([H|T],X,S).

continuar(M,P,S):-
	write("Continuar? S/N "),
	read_line_to_codes(user_input, A3),
	string_to_atom(A3,A12),
	atom_string(A12,A),
	
	A = "S" -> formaPalavra(M,P,S); S=P. 

	
leIndices(L,C) :- write("Digite a Linha: "),
				  read_line_to_codes(user_input, A3),
				  string_to_atom(A3,A12),
				  atom_number(A12,L),
				 
				  write("Digite a Coluna: "),
				  read_line_to_codes(user_input, B3),
				  string_to_atom(B3,B12),
				  atom_number(B12,C).
				  
procuraletra([H|T],L,C,LETRA) :-
		linha([H|T],L,X),
		coluna(X,C,LETRA).

linha(M,L,X) :-
	nth0(L,M,X).
	
coluna(X,C,LETRA):-
	atom_chars(X,L1),
	nth0(C,L1,LETRA).

encontrarPalavra(M,L,R) :-
	formaPalavra(M,"",S),
	find(L,S,R).

find([],_,R) :- R = "Palavra nao foi encontrada".
find([H|T],E,R) :-
    (H\==E) -> find(T,E,R); R = "Palavra Encontrada".

:- initialization main.

main :-
	M = ["casads","sacdsa"],
	L = ["patio","casa"],
	
	
	encontrarPalavra(M,L,R),
	write(R),nl.
	
