-module(hello).
	-export([hello_world/0]).
    -export([dobro/1]).
    -export([fatorial/1]).

	hello_world() -> io:fwrite("hello, world\n").



    dobro(X) -> X+X.

    fatorial(0) -> 1;
    fatorial(N) -> N * fatorial(N - 1).
       
    