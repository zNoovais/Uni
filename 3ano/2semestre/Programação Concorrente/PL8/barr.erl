-module[barr].
-export([new/1, await/1]).

re 

await(Barrier) -> 
    Barrier ! {await,self()},
    receive ok -> ok end.

loop(N,N,Pids) ->
    [Pid ! ok || Pid <- Pids],
    loop(N, 0, []);
loop(N,C,Pids) ->
    receive {await, From} ->
        loop(N,C+1, [From | Pids])
    end. 
