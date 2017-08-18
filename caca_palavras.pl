letraAleatoria(L) :- random(0,25,X),
					 nth0(X,['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'], L).

cacaPalavras(["1111111111","1111111111","1111111111","1111111111","1111111111","1111111111","1111111111","1111111111","1111111111","1111111111"]).

desenhaLinha([]).
desenhaLinha([H|T]) :- write(H), write(" "), desenhaLinha(T).


desenhaMatriz([]). 
desenhaMatriz([H|T]) :-string_chars(H, ArrayCharH), 
 		     desenhaLinha(ArrayCharH), 
		     nl, 
		     desenhaMatriz(T).

concatenar([], L, L).
concatenar([H|T], L, [H|D]) :- concatenar(T, L, D).

inverte([], []).
inverte([H|T], L) :- inverte(T, X), concatenar(X, [H], L).


retiraUnsP([], PM, R) :- inverte(PM, I), R = I.
retiraUnsP([H|T], PM, R) :- H == '1' -> letraAleatoria(L), inserePalavraLista(L, PM, LPM), retiraUnsP(T, LPM, R); 
					      inserePalavraLista(H, PM, LPM), retiraUnsP(T, LPM, R).

retiraUnsCP([], CPM, R) :- inverte(CPM, I), R = I.
retiraUnsCP([H|T], CPM, R) :- string_chars(H, H1), retiraUnsP(H1, [], LSU), string_chars(PSU, LSU), inserePalavraLista(PSU, CPM, LCPM), retiraUnsCP(T, LCPM, R).

verificaRepetida(X, [], R) :- R = 1.
verificaRepetida(X,[H|T], R):- X == H -> R = 0, write("Palavra repetida, digite outra!"), nl; 
					   verificaRepetida(X,T, R), R = 1.

inserePalavraLista(X, L, [X|L]).

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
						verificaRepetida(P, Palavras, X),
						R =:= 1, S =:= 1, X =:= 1 -> Palavra = P;
						verificaPalavra(Palavra, Palavras).

cls :- write('\e[H\e[2J').

leInteiro(N) :- read_line_to_codes(user_input, A3),
				string_to_atom(A3,A12),
				atom_number(A12,N).
				
leString(S) :- read_line_to_codes(user_input, P2),
			   string_to_atom(P2,P1),
			   atom_string(P1,S).
			
adicionaElemento(ContColuna,[L|Ls],Letra,ContColuna,[Letra|Ls]).
adicionaElemento(ContColuna,[L|Ls],Letra,Coluna,[L|X]):-
	N is ContColuna +1,
	adicionaElemento(N,Ls,Letra,Coluna,X).			

verificaVertical(_,_,_,0,'P').
verificaVertical(_,10,_,_,'N').
verificaVertical(Linha,Coluna,M,Tamanho,Retorno):-
	nth0(Linha,M, Palavra),
	string_chars(Palavra,Lista),
	nth0(Coluna,Lista,'1') -> I is Linha +1, T is Tamanho -1, verificaVertical(I,Coluna,M,T,Retorno); Retorno = 'N'.
						
vertical(_,[M|Mt],[],_,_,[M|Mt]).
vertical(ContLinha,[M|Mt],[P|Ps],ContLinha,Coluna,[Palavra|X]):-
	string_chars(M,Lista),
	adicionaElemento(0,Lista,P,Coluna,ListaRetorno),
	string_chars(Palavra,ListaRetorno),
	vertical(ContLinha,Mt,Ps,ContLinha,Coluna,X).
	
vertical(ContLinha,[M|Mt],[P|Ps],Linha,Coluna,[M|X]):- 
	N is ContLinha +1,
	vertical(N,Mt,[P|Ps],Linha,Coluna,X).	
	
	
horizontal(_,[M|Mt],[],_,_,[M|Mt]).
horizontal(ContLinha,[M|Mt],[P|Ps],ContLinha,Coluna,X):-
	string_chars(M,Lista),
	adicionaElemento(0,Lista,P,Coluna,ListaRetorno),
	N is Coluna + 1,
	string_chars(Palavra,ListaRetorno),
	horizontal(ContLinha,[Palavra|Mt],Ps,ContLinha,N,X).
	
horizontal(ContLinha,[M|Mt],[P|Ps],Linha,Coluna,[M|X]):- 
	N is ContLinha +1,
	horizontal(N,Mt,[P|Ps],Linha,Coluna,X).

verificaHorizontal(_,_,_,0,'P').
verificaHorizontal(_,10,_,_,'N').
verificaHorizontal(Linha,Coluna,M,Tamanho,Retorno):-
	nth0(Linha,M, Palavra),
	string_chars(Palavra,Lista),
	nth0(Coluna,Lista,'1') -> J is Coluna +1, T is Tamanho -1, verificaHorizontal(Linha,J,M,T,Retorno); Retorno = 'N'.


diagonal(_,[M|Mt],[],_,_,[M|Mt]).
diagonal(ContLinha,[M|Mt],[P|Ps],ContLinha,Coluna,[Palavra|X]):-
	string_chars(M,Lista),
	adicionaElemento(0,Lista,P,Coluna,ListaRetorno),
	string_chars(Palavra,ListaRetorno),
	N is Coluna +1,
	diagonal(ContLinha,Mt,Ps,ContLinha,N,X).
	
diagonal(ContLinha,[M|Mt],[P|Ps],Linha,Coluna,[M|X]):- 
	N is ContLinha +1,
	diagonal(N,Mt,[P|Ps],Linha,Coluna,X).

verificaDiagonal(_,_,_,0,'P').
verificaDiagonal(_,10,_,_,'N').
verificaDiagonal(Linha,Coluna,M,Tamanho,Retorno):-
	nth0(Linha,M, Palavra),
	string_chars(Palavra,Lista),
	nth0(Coluna,Lista,'1') -> I is Linha + 1, J is Coluna + 1, T is Tamanho - 1, verificaDiagonal(I,J,M,T,Retorno); Retorno = 'N'.



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
	/* instrucoes */
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
	
	/* define caca palavras */
	cacaPalavras(CP),
	
	
	/* recebe, valida e coloca a primeira palavra na vertical */
	Palavras0 = [],
	verificaPalavra(Palavra1, Palavras0),
	string_chars(Palavra1, Char1),
	length(Char1,Y),
	verificaVertical(0, 1, CP, Y, T1),
	vertical(0, CP, Char1,0,1,CP1),
	inserePalavraLista(Palavra1, Palavras0, Palavras1),
	
	/*recebe, valida e coloca a segunda palavra na horizontal */
	verificaPalavra(Palavra2, Palavras1),
	string_chars(Palavra2, Char2),
	length(Char2,X),
	verificaHorizontal(0, 2, CP1, X, Q1),
	horizontal(0, CP1, Char2, 0, 2, CP2),
	inserePalavraLista(Palavra2, Palavras1, Palavras2),
	
	/* recebe, valida e coloca a terceira palavra na diagonal */
	verificaPalavra(Palavra3, Palavras2), 
	string_chars(Palavra3, Char3),
	length(Char3,W),
	verificaDiagonal(2, 2, CP2, W, W1),
	diagonal(0, CP2, Char3, 2, 2, CP3),
	inserePalavraLista(Palavra3, Palavras2, Palavras3),
	
	/* recebe, valida e coloca a terceira palavra invertida */
	verificaPalavra(Palavra4, Palavras3),
	string_chars(Palavra4, Char4),
	inverte(Char4, Invertida),
	length(Char4, E),
	verificaHorizontal(8, 2, CP3, E, E1),
	horizontal(0, CP3, Char4, 8, 2, CP4),
	inserePalavraLista(Palavra4, Palavras3, Palavras4),
	retiraUnsCP(CP4, [], CPF),
	
	write("As palavras foram escondidas no caça palavras abaixo!"),nl,
	write(""),nl,
	desenhaMatriz(CPF),
	write(""),nl,
	write("Agora que as palavras foram escondidas, você deve procurá-las digitando os "),nl,
	write("valores das linhas e colunas correspondentes à cada letra da palavra."),nl,
	write(""),nl,
	
	encontrarPalavra(CPF,Palavras4,R),
	write(R), nl.



