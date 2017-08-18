cls :- write('\e[H\e[2J').

leInteiro(N) :- read_line_to_codes(user_input, A3),
		string_to_atom(A3,A12),
		atom_number(A12,N).
				
leString(S) :- read_line_to_codes(user_input, P2),
	       string_to_atom(P2,P1),
               atom_string(P1,S).

conc([],L,L).      		%  A lista vazia concatenada com qualquer lista resulta
conc([X|L1],L2,[X|L3]):-	%  nesta propria lista.  A concatenação de duas listas
conc(L1,L2,L3).

desenhaLinha([]).
desenhaLinha([H|T]) :- write(H), write(" "), 
                       desenhaLinha(T).


desenhaMatriz([]). 
desenhaMatriz([H|T]) :- string_chars(H, ArrayCharH), 
 		     desenhaLinha(ArrayCharH), 
		     nl, 
		     desenhaMatriz(T).


letraAleatoria(L) :- random(0,25,X),
		  nth0(X,['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'], L).


tam([], 0).
tam([_|T], S) :- tam(T, G), S is 1 + G.

insere(X, L, [X|L]).

preencheMatriz(0, [_], []).
preencheMatriz(Ind, [H|T], Resultado) :- tam(H, TamLinha), TamLinha < 10  -> letraAleatoria(X), insere(X, H, Result), preencheMatriz(Ind, [Result|T], Resultado);
					 N is Ind - 1, preencheMatriz(N, T, J), conc(H, J, Resultado), write(Resultado).



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
	
	/*?-random(0, 9999, X), .  gera numero aleatoriole primeira palavra*/
	
	preencheMatriz(9, Param, Matriz),nl.
	desenhaMatriz(Matriz).

	
