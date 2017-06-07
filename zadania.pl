ostatni([X],X).
ostatni([_|T],X):-ostatni(T,X).

przedostatni([X,_],X).
przedostatni([_,Y|T],X):-przedostatni([Y|T],X).

kelement([X|_],[X],1).
kelement([_|T],X,N):- N1 is N-1, kelement(T,X,N1).

lelement([],0).
lelement([_|T],N):- lelement(T,N1), N is N1+1.

odwroc([X],[X]).
odwroc([H|T],L2):- odwroc(T,T2), append(T2,[H],L2).

srodkowy([X],X).
srodkowy([_|T],X):- append(T2,[_],T), srodkowy(T2,X).

doposort([],[X],X).
doposort([H|T],[X,H|T],X):- X<H.
doposort([H|T],[H|L2],X):- X>=H, doposort(T,L2,X).

insertion([],[]).
insertion([H|T],L2):- insertion(T,L3), doposort(L3,L2,H).

zamien([X],[X]).
zamien([H1,H2|T],[H2,H1|T]):- H2<H1.
zamien([H1,H2|T],[H1|L]):- H1=<H2, zamien([H2|T],L).

bubble(X,X):-zamien(X,X1),X=X1.
bubble(X,Y):- zamien(X,X1),X\=X1,bubble(X1,Y).

podziel(_,[],[],[]).
podziel(X,[H|T],[H|L],P):-H<X,podziel(X,T,L,P).
podziel(X,[H|T],L,[H|P]):-H>=X,podziel(X,T,L,P).
quick([],[]).
quick([H|T],X):-podziel(H,T,M,W),quick(M,X1),quick(W,X2),append(X1,[H|X2],X).

binarnie(0,[]).
binarnie(1,[1]).
binarnie(X,L2):- X1 is X mod 2, X2 is X//2, binarnie(X2,L), append(L,[X1],L2),!.

ilezer([],0).
ilezer([H|T],N):- H is 0, ilezer(T,N1), N is N1+1.
ilezer([H|T],N):- H\=0, ilezer(T,N).

ilejedynek([],0).
ilejedynek([H|T],N):- H is 1, ilejedynek(T,N1), N is N1+1.
ilejedynek([H|T],N):- H\=1, ilejedynek(T,N).


zamien2([],[]).
zamien2([X],[X]).
zamien2([H1,H2|T],[H2,H1|T]):-binarnie(H1,L1),binarnie(H2,L2),ilezer(L1,Z1),ilejedynek(L1,J1),ilezer(L2,Z2),ilejedynek(L2,J2), R1 is J1-Z1, R2 is J2-Z2,R2<R1.
zamien2([H1,H2|T],[H1|L]):- H1=<H2, zamien2([H2|T],L).

bubble2(X,X):-zamien2(X,X1),X=X1.
bubble2(X,Y):- zamien2(X,X1),X\=X1,bubble2(X1,Y).

min([X],X):-!.
min([H|T],H):- min(T,X1), H<X1,!.
min([H|T],X1):-min(T,X1),H>=X1.

max([X],X):-!.
max([H|T],H):- max(T,X1), H>X1,!.
max([H|T],X1):-max(T,X1),H=<X1.

mindosrodka(L,L):-min(L,X), append(L1,[X|L2],L), length(L1,D1),length(L2,D2), D1=D2,!.
mindosrodka(Lwe, Lwy):-append(T, [H], Lwe), mindosrodka([H|T], Lwy).

maxdosrodka(L,L):-max(L,X), append(L1,[X|L2],L), length(L1,D1),length(L2,D2), D1=D2,!.
maxdosrodka(Lwe, Lwy):-append(T, [H], Lwe), maxdosrodka([H|T], Lwy).

suma([],[],0).
suma([H1|T1],[H2|T2],S):- Pom is H2-H1, suma(T1,T2,S1), S is S1+abs(Pom).


zamien3([],[]).
zamien3([X],[X]).
zamien3([H1,H2|T],[H2,H1|T]):-mindosrodka(H1,H1min), maxdosrodka(H1,H1max),suma(H1min,H1max,R1),mindosrodka(H2,H2min), maxdosrodka(H2,H2max),suma(H2min,H2max,R2),R2<R1.
zamien3([H1,H2|T],[H1|L]):-mindosrodka(H1,H1min), maxdosrodka(H1,H1max),suma(H1min,H1max,R1),mindosrodka(H2,H2min), maxdosrodka(H2,H2max),suma(H2min,H2max,R2),R1=<R2, zamien3([H2|T],L).

bubble3(X,X):-zamien3(X,X1),X=X1.
bubble3(X,Y):- zamien3(X,X1),X\=X1,bubble3(X1,Y).

najwzmniej([_],X,X).
najwzmniej([H|T],H,Y):-najwzmniej(T,X,Y),H<Y,H>X,X\=Y,!.
najwzmniej([H|T],H,Y):-najwzmniej(T,X,Y),H<Y,X=:=Y,!.
najwzmniej([_|T],X,Y):-najwzmniej(T,X,Y),!.

najmzwie([_],X,X).
najmzwie([H|T],H,Y):-najmzwie(T,X,Y),H>Y,H<X,X\=Y,!.
najmzwie([H|T],H,Y):-najmzwie(T,X,Y),H>Y,X=:=Y,!.
najmzwie([_|T],X,Y):-najmzwie(T,X,Y),!.

klucz(L,Min,Max):-min(L,Min), max(L,Max).

zamien4([],[]).
zamien4([X],[X]).
zamien4([H1,H2|T],[H2,H1|T]):-append(L1,[K1],H1),append([P1],L2,L1),klucz([P1,K1],Min1,Max1),append(L3,[K2],H1),append([P2],L4,L3), klucz([P2,K2],Min2,Max2),najwzmniej(L2,X1,Min1),najmzwie(L2,X2,Max1),najwzmniej(L4,X3,Min2),najmzwie(L4,X4,Max2),R1 is X2-X1, R2 is X4-X3,R2<R1.
zamien4([H1,H2|T],[H1|L]):-append(L1,[K1],H1),append([P1],L2,L1),klucz([P1,K1],Min1,Max1),append(L3,[K2],H1),append([P2],L4,L3), klucz([P2,K2],Min2,Max2),najwzmniej(L2,X1,Min1),najmzwie(L2,X2,Max1),najwzmniej(L4,X3,Min2),najmzwie(L4,X4,Max2),R1 is X2-X1, R2 is X4-X3,R1 is X2-X1, R2 is X4-X3,R1=<R2, zamien4([H2|T],L).

bubble4(X,X):-zamien4(X,X1),X=X1.
bubble4(X,Y):- zamien4(X,X1),X\=X1,bubble4(X1,Y).

doprzodu(L,L):-min(L,Min), append([Min],_,L), !.
doprzodu(L,L1):-append(T,[H],L),doprzodu([H|T],L1).

dotylu(L,L):-max(L,Max), append(_,[Max],L),!.
dotylu(L,L1):-append(T,[H],L),dotylu([H|T],L1).

roznica([],[],0).
roznica([H1|T1],[H2|T2],S):-Pom is abs(H2-H1), roznica(T1,T2,N), S is N+Pom.

zamien5([],[]).
zamien5([X],[X]).
zamien5([H1,H2|T],[H2,H1|T]):-doprzodu(H1,L1),dotylu(H1,L2),doprzodu(H2,L3),dotylu(H2,L4),roznica(L1,L2,R1),roznica(L3,L4,R2),R2<R1.
zamien5([H1,H2|T],[H1|L]):-doprzodu(H1,L1),dotylu(H1,L2),doprzodu(H2,L3),dotylu(H2,L4),roznica(L1,L2,R1),roznica(L3,L4,R2),R1=<R2, zamien5([H2|T],L).

bubble5(X,X):-zamien5(X,X1),X=X1.
bubble5(X,Y):- zamien5(X,X1),X\=X1,bubble5(X1,Y).

policz([],_,0,_).
policz([H|T],X,N,Krok):-X1 is X+Krok,policz(T,X1,N1,Krok), Pom is X-H, N is N1+Pom.

zamien6([],[]).
zamien6([X],[X]).
zamien6([H1,H2|T],[H2,H1|T]):-append(_,[K1],H1),append([P1],_,H1),Krok is (K1+P1)//2,policz(H1,P1,R1,Krok),append(_,[K2],H2),append([P2],_,H2),Krok2 is (K2+P2)//2,policz(H2,P2,R2,Krok2),R2<R1.
zamien6([H1,H2|T],[H1|L]):-append(_,[K1],H1),append([P1],_,H1),Krok is (K1+P1)//2,policz(H1,P1,R1,Krok),append(_,[K2],H2),append([P2],_,H2),Krok2 is (K2+P2)//2,policz(H2,P2,R2,Krok2),R1=<R2, zamien6([H2|T],L).

bubble6(X,X):-zamien6(X,X1),X=X1.
bubble6(X,Y):- zamien6(X,X1),X\=X1,bubble6(X1,Y).

sortuj([],[]).
sortuj([H|T],[H2|T2]):-bubble(H,H2),sortuj(T,T2).

key(Lwe,Lwy):- sortuj(Lwe,L2), bubble6(L2,Lwy).

wyrownaj(L1,L2,L1,L2):-length(L1,X1),length(L2,X2),X1=:=X2,!.
wyrownaj(L1,L2,L3,L4):-length(L1,X1),length(L2,X2),X1<X2,append([0],L1,Lx),wyrownaj(Lx,L2,L3,L4).
wyrownaj(L1,L2,L3,L4):-length(L1,X1),length(L2,X2),X1>X2,append([0],L2,Lx),wyrownaj(L1,Lx,L3,L4).

xor([],[],[]).
xor([H1|T1],[H2|T2],L):- H1=:=H2, xor(T1,T2,L1), append([0],L1,L).
xor([H1|T1],[H2|T2],L):- H1=\=H2, xor(T1,T2,L1), append([1],L1,L).

dziesietnie([],0,0).
dziesietnie([H|T],N,P):-dziesietnie(T,N1,P1), N is N1+(H*(2**P1)),P is P1+1.

zamien7([],[],[],[]).
zamien7([X],[X],[Y],[Y]).
zamien7([H1,H2|T],[H2,H1|T],[H3,H4|T2],[H4,H3|T2]):-H4<H3.
zamien7([H1,H2|T],[H1|L],[H3,H4|T2],[H3|L2]):-H3=<H4, zamien7([H2|T],L,[H4|T2],L2).

bubble7(X,X,X2,X2):-zamien7(X,_,X2,X3),X2=X3.
bubble7(X,Y,X2,Y2):- zamien7(X,X1,X2,X3),X2\=X3,bubble7(X1,Y,X3,Y2).

listabin([],[]).
listabin([H|T],[H1|L]):-binarnie(H,H1), listabin(T,L).

listawyr([],[],X,X).
listawyr([H|T],[H1|T2],Maska,Maska2):- listawyr(T,T2,Maska,Maska1),wyrownaj(H,Maska1,H1,Maska2).

listaxor([],[],_).
listaxor([H|T],[H1|T2],Maska):-xor(H,Maska,H1),listaxor(T,T2,Maska).

listadzies([],[]).
listadzies([H|T],[H1|T1]):-dziesietnie(H,H1,_),listadzies(T,T1).


key(Lwe,M,Lwy):-listabin(Lwe,L1),binarnie(M,Maska),listawyr(L1,L12,Maska,Maskap1),listawyr(L12,L2,Maskap1,Maska1),listaxor(L2,L3,Maska1),listadzies(L3,L4), bubble7(Lwe,Lwy,L4,_).


cyfry(0,[]).
cyfry(N,L):-N1 is N//10, N2 is N mod 10, cyfry(N1,L1), append(L1,[N2],L),!.

rosnacy([],[]).
rosnacy([X],[X]).
rosnacy([H1,H2|T],[H1|L]):- H1>H2, rosnacy(T,L),!.
rosnacy([H1,H2|T],[H1|T2]):-H2>=H1, rosnacy([H2|T],T2),!.

liczby([],0,0).
liczby([H|T],N,P):-liczby(T,N1,P1),N is N1+(H*(10**P1)),P is P1+1,!.

zamien8([],[]).
zamien8([X],[X]).
zamien8([H1,H2|T],[H2,H1|T]):-cyfry(H1,L1),cyfry(H2,L2),rosnacy(L1,L11),rosnacy(L2,L22),liczby(L11,R1,_),liczby(L22,R2,_),R2<R1.
zamien8([H1,H2|T],[H1|L]):-cyfry(H1,L1),cyfry(H2,L2),rosnacy(L1,L11),rosnacy(L2,L22),liczby(L11,R1,_),liczby(L22,R2,_), R1=<R2, zamien8([H2|T],L).

bubble8(X,X):-zamien8(X,X1),X=X1.
bubble8(X,Y):- zamien8(X,X1),X\=X1,bubble8(X1,Y).

liczbity([_],[],1).
liczbity([H1,H2|T],[X1|L],1):- H1=\=H2, liczbity([H2|T],L,X1).
liczbity([H1,H2|T],L,X):-H1=:=H2, liczbity([H2|T],L,X1), X is X1+1.

wszystkiebity(Lwe,Lwy):-liczbity(Lwe,L1,X), append([X],L1,Lwy).

zamien9([],[]).
zamien9([X],[X]).
zamien9([H1,H2|T],[H2,H1|T]):-binarnie(H1,L1),binarnie(H2,L2),wszystkiebity(L1,L11),wszystkiebity(L2,L22),liczby(L11,R1,_),liczby(L22,R2,_),R2<R1.
zamien9([H1,H2|T],[H1|L]):-binarnie(H1,L1),binarnie(H2,L2),wszystkiebity(L1,L11),wszystkiebity(L2,L22),liczby(L11,R1,_),liczby(L22,R2,_), R1=<R2, zamien9([H2|T],L).

bubble9(X,X):-zamien9(X,X1),X=X1.
bubble9(X,Y):- zamien9(X,X1),X\=X1,bubble9(X1,Y).
