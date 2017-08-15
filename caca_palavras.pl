leIndices(L,C) :- write("Digite a Linha: "),
				  read_line_to_codes(user_input, A3),
				  string_to_atom(A3,A12),
				  atom_number(A12,L),
				 
				  write("Digite a Coluna: "),
				  read_line_to_codes(user_input, B3),
				  string_to_atom(B3,B12),
				  atom_number(B12,C).
				  
				  
formaPalavra([H|T],P1) :- 
	
	leIndices(LI,COL),
	procuraletra([H|T],LI,COL,LETRA),
	
	write(LETRA),nl,
	
	string_concat(P1,LETRA,X),
	
	write("Continuar? S/N "),
	read_line_to_codes(user_input, A3),
	string_to_atom(A3,A12),
	atom_string(A12,A),
	
	write(X),nl,
	
	A = "S" -> formaPalavra([H|T],X); write("FIM"),nl. 


procuraletra([H|T],L,C,LETRA) :-
		linha([H|T],L,X),
		coluna(X,C,LETRA).

linha(M,L,X) :-
	nth0(L,M,X).
	
coluna(X,C,LETRA):-
	atom_chars(X,L1),
	nth0(C,L1,LETRA).


	
	
:- initialization main.

main :-
	M = ["abcde","acdsa"],
	
	P = "",
	formaPalavra(M,P),
	write(P),nl,
	halt(0).
	
