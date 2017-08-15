cls :- write('\e[H\e[2J').

insere(X, L, [X|L]).

insereFim(N, [], [N]).
insereFim(T, [H], L) :- insere(H, [T], L).
insereFim(N, [H|T], L) :- insereFim(N, T, X), insere(H, X, L).

leInteiro(N) :- read_line_to_codes(user_input, A3),
				string_to_atom(A3,A12),
				atom_number(A12,N).
				
leString(S) :- read_line_to_codes(user_input, P2),
			   string_to_atom(P2,P1),
			   atom_string(P1,S).

cacaPalavras(["","","","","","","","","",""]).

replace(_, _, [], []).
replace(O, R, [O|T], [R|T2]) :- replace(O, R, T, T2).
replace(O, R, [H|T], [H|T2]) :- H \= O, replace(O, R, T, T2).

letraAleatoria(L) :- random(0,25,X),
					 nth0(X,['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'], L).  


preencheString(Palavra, 10, Palavra).
preencheString(Palavra, Tamanho, Modificada) :- letraAleatoria(L), string_concat(Palavra, L, X), Z is Tamanho +1, preencheString(X, Z, Modificada).

preencheMatriz([], R):-!.
preencheMatriz([H|T], R) :-
	string_chars(H, H1),
	length(H1, Y),
	preencheString(H, Y, R),
	preencheMatriz(T,[R]).
						 
vertical(_, _, "", _, MatrizResultante).
vertical(I, J, Palavra, Matriz, MatrizResultante) :- write("OK").


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
	
	*/
	
	cacaPalavras(X),
	preencheMatriz(X, L),
	write(L).
