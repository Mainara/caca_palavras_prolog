cls :- write('\e[H\e[2J').

leInteiro(N) :- read_line_to_codes(user_input, A3),
				string_to_atom(A3,A12),
				atom_number(A12,N).
				
leString(S) :- read_line_to_codes(user_input, P2),
			   string_to_atom(P2,P1),
			   atom_string(P1,S).

--imprimeMatriz([]) :- nl.
--imprimeMatriz(H|T) :- S is separaLetras(H), write("                 "), write(S), nl, imprimeMatriz(T).

--separaLetras([P], [R]) :- string_concat(P, " ", R).
--separaLetras([P|Ps], [R|Rs]) :- string_concat(P, " ", R), separaLetras(Ps, Rs).
								 


:- initialization main.

main :-
	
	write(""), nl,
	write("*********************JOGO DE CAÇA PALAVRAS*********************"), nl,
	write(""), nl,
	write("Intruções: "), nl,
	write("   1 - Você irá digitar as 4 palavras que serão escondidas."), nl,
	write("   2 - Você deverá digitar as palavras que serão escondidas uma por vez."), nl,
	write("        - As palavras não devem possuir inteiros."), nl,
	write("        - As palavras devem possuir entre 2 e 10 letras."), nl,
	write("        - Não deve possuir palavras repetidas."), nl,
	write("   3 - Para procurar as palavras você irá precisar informar as linhas e as colunas das palavras que será formada."), nl,
	write("   4 - O jogo será finalizado quando todas as palavras forem encontradas."), nl,
	write(""), nl,
	write("Digite as palavras seguidas de um enter: "), nl,
	
	/*?-random(0, 9999, X), .  gera numero aleatorio
	
	le primeira palavra*/
	string_chars("abracadabra", Lista),
	separaLetras(Lista, Separado),
	write(Separado),nl,
