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

cacaPalavras(["1111111111","1111111111","1111111111","1111111111","1111111111","1111111111","1111111111","1111111111","1111111111","1111111111"]).

letraAleatoria(L) :- random(0,25,X),
					 nth0(X,['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'], L).  

adicionaElemento(ContColuna,[L|Ls],Letra,ContColuna,[Letra|Ls]).
adicionaElemento(ContColuna,[L|Ls],Letra,Coluna,[L|X]):-
	N is ContColuna +1,
	adicionaElemento(N,Ls,Letra,Coluna,X).
	
vertical(_,[M|Mt],[],_,_,[M|Mt]).
vertical(ContLinha,[M|Mt],[P|Ps],ContLinha,Coluna,[Palavra|X]):-
	string_chars(M,Lista),
	adicionaElemento(0,Lista,P,Coluna,ListaRetorno),
	string_chars(Palavra,ListaRetorno),
	vertical(ContLinha,Mt,Ps,ContLinha,Coluna,X).
	
vertical(ContLinha,[M|Mt],[P|Ps],Linha,Coluna,[M|X]):- 
	N is ContLinha +1,
	vertical(N,Mt,[P|Ps],Linha,Coluna,X).

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
	
verificaVertical(_,_,_,0,'P').
verificaVertical(_,10,_,_,'N').
verificaVertical(Linha,Coluna,M,Tamanho,Retorno):-
	nth0(Linha,M, Palavra),
	string_chars(Palavra,Lista),
	nth0(Coluna,Lista,'1') -> I is Linha +1, T is Tamanho -1, verificaVertical(I,Coluna,M,T,Retorno); Retorno = 'N'.

verificaDiagonal(_,_,_,0,'P').
verificaDiagonal(_,10,_,_,'N').
verificaDiagonal(Linha,Coluna,M,Tamanho,Retorno):-
	nth0(Linha,M, Palavra),
	string_chars(Palavra,Lista),
	nth0(Coluna,Lista,'1') -> I is Linha + 1, J is Coluna + 1, T is Tamanho - 1, verificaDiagonal(I,J,M,T,Retorno); Retorno = 'N'.


:- initialization main.

main :-
	
	nl,
	write("*********************JOGO DE CAÇA PALAVRAS*********************"), nl,
	nl,
	write("Intruções: "), nl,
	write("   1 - Você irá digitar as 4 palavras que serão escondidas."), nl,
	write("   2 - Você deverá digitar as palavras que serão escondidas uma por vez."), nl,
	write("        - As palavras não devem possuir inteiros."), nl,
	write("        - As palavras devem possuir entre 2 e 10 letras."), nl,
	write("        - Não deve possuir palavras repetidas."), nl,
	write("   3 - Para procurar as palavras você irá precisar informar as linhas e as colunas das palavras que será formada."), nl,
	write("   4 - O jogo será finalizado quando todas as palavras forem encontradas."), nl,
	nl,
	write("Digite as palavras seguidas de um enter: "), nl,
	
	/*?-random(0, 9999, X), .  gera numero aleatorio
	
	*/
	
	cacaPalavras(X),
	verificaDiagonal(0,3,X,4,T1),
	diagonal(0,X,['F','O','G','O'],0,3,R),
	verificaDiagonal(0,3,R,4,T),
	write(T1),
	write(T).
