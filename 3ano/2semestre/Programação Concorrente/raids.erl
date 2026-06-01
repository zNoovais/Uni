-module(raids).
-export([create/1,join/3,players/1,waitStart/1,leave/1]).

create(R) -> spawn(fun() -> manager(R,0,[],[],0,[]) end) 
    .

join(Manager, Name, Min) ->
    Manager ! {join, Name, Min, self()},
    receive {raid,Raid} -> Raid.

players(Raid) ->
    Raid ! {players, self()},
    receive {names, Names} -> Names.
    

waitStart(Raid) ->
    Raid ! {players, self()},
    receive {start} -> ok end.

leave(Raid) ->
    Raid ! leave.

manager(R, MaxMin, Names, PlayerPids, Running, RaidsPending) when MaxMin =:= length(Names) ->
    Self = self(),
    Raid = spawn(fun -> raid(Names,length(Names),false, 0, Self) end),
    [Pid ! {raid,Raid} || Pid <- Players],
    if 
        Running < R ->
            Raid ! start,
            manager(R, 0, [], [], Running + 1, RaidsPending);
        true -> 
            manager(R, 0, [], [],Running,RaidsPending ++ [Raid])
        end;

manager(R, MaxMin, Names, PlayerPids, Running, RaidsPending) ->
    receive 
        {join,Name,Min,From} -> 
            manager(R,max(MaxMin,Min),[Name | Names],[From | PlayerPids],Running,RaidsPending)
        end.
        {finished} -> 
            case RaidsPending of
                [Raid | Rest] -> 
                    Raid ! {start},
                    manager(R, MaxMin, Names, PlayerPids, Running, Rest);
                [] ->
                    manager(R, MaxMin, Names, PlayerPids, Running-1, RaidsPending)
                end.

raid(Names, Playing, Started, Waiting,Manager) when Playing =:= 0 ->
    Manager ! {finished};

raid(Names, Playing, Started, Waiting,Manager) ->
    receive
        {players,From} ->
            From ! {names,Names},
            raid(Names,Playing,Started);
        {waitStart, From} ->
            case Started of
                true ->
                    From ! {started},
                    raid(Names, Playing, Started, Waiting,Manager);
                false ->
                    raid(Names, Playing, Started, [From | Waiting])
            end;

        {leave} ->
            raid(Names, Playing - 1, Started, Waiting,Manager);
        {start} -> 
            [Pid ! {started} || Pid <- Waiting],
            raid(Names, Playing, true, [], Manager)

            
    end.