pertence(X, [], R) :- R = 1.
pertence(X,[H|T], R):- X == H -> R = 0, write("Palavra repetida, digite outra!"), nl; 
					   pertence(X,T, R), R = 1.

insere(X, L, [X|L]).

verificaTamanho(Palavra, R) :- string_chars(Palavra,H1),
						length(H1,Y),
						Y >= 2, Y =< 10 -> R = 1; 
						write("Essa palavra não possui de 2 à 10 letras, digite outra palavra!"),nl, R = 0.
						
verificaInteiro([], R) :- R = 1.
verificaInteiro([H|T], R) :- (H == '1'; H == '2'; H == '3'; H == '4'; H == '5';
                             H == '6'; H == '7'; H == '8'; H == '9'; H == '0') -> R = 0, 
                             write("Essa palavra não possui inteiro, digite outra palavra!"),nl; 
                             verificaInteiro(T, R).

verificaPalavra(Palavra, Palavras) :- leString(P),
						verificaTamanho(P, R),
						string_chars(P,H1),
						verificaInteiro(H1, S),
						pertence(P, Palavras, X),
						R =:= 1, S =:= 1, X =:= 1 -> Palavra = P;
						verificaPalavra(Palavra, Palavras).

cls :- write('\e[H\e[2J').

leInteiro(N) :- read_line_to_codes(user_input, A3),
				string_to_atom(A3,A12),
				atom_number(A12,N).
				
leString(S) :- read_line_to_codes(user_input, P2),
			   string_to_atom(P2,P1),
			   atom_string(P1,S).
								 

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
	Palavras0 = [],
	verificaPalavra(Palavra1, Palavras0),
	insere(Palavra1, Palavras0, Palavras1), 
	verificaPalavra(Palavra2, Palavras1),
	insere(Palavra2, Palavras1, Palavras2), 
	verificaPalavra(Palavra3, Palavras2),
	insere(Palavra3, Palavras2, Palavras3), 
	verificaPalavra(Palavra4, Palavras3),
	insere(Palavra4, Palavras3, Palavras4), 
	write(Palavras4).
	
