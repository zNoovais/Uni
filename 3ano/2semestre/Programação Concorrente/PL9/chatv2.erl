-module(chatv2).
-export([start/1, stop/1]).

start(Port) -> 
            login_manager:start(),
            spawn(fun() -> server(Port) end).

stop(Server) -> Server ! stop,
            login_manager:stop().

startRM() -> 
spawn(fun()-> room_manager(#{})end).


getRoom(RM,Name) ->
RM ! {get,Name,self()},
receive {room,RoomPid} -> RoomPid end.


room_manager(Map) ->  %%%% CONTADOR DE PESSOAS A CADA SALA 
receive
    {enter,Name,From} -> 
        {Room,NewMap} =
        case maps:find(Name, Map) of
            {ok,{Counter,R}} -> 
                R ! {enter, From},
                {Room,maps:put(Name,{Counter+1,R},Map)};

        error -> 
            R = spawn(fun()-> room(Name, []) end),
            {R, maps:put(Name,{1,R},Map)}
        end,
        From ! {room,Room},
        room_manager(NewMap);

    {leave,Name,From} ->
        {Room,NewMap} =
        case maps:find(Name,Map) of
            {ok,{1,R}} -> {Room,maps:remove(Name,Map)};
            
            {ok,{Counter,R}} -> 

end.


server(Port) ->
{ok, LSock} = gen_tcp:listen(Port, [binary, {packet, line}, {reuseaddr, true}]),
RoomManager = startRM(),
spawn(fun() -> acceptor(LSock, RoomManager) end),
receive stop -> ok end.

acceptor(LSock, RoomManager) ->
{ok, Sock} = gen_tcp:accept(LSock),
spawn(fun() -> acceptor(LSock, RoomManager) end),
user_not_auth(Sock, RoomManager).

room(RoomName, Pids) ->
receive
    {enter, Pid} ->
    io:format("[~s] user entered~n", [RoomName]),
    room(RoomName, [Pid | Pids]);
    {line, User, Data} = Msg ->
    io:format("received [~s] ~s: ~p~n", [RoomName, User, Data]),
    [Pid ! {line, User, RoomName, Data} || Pid <- Pids],
    room(RoomName, Pids);
    {leave, Pid} ->
    io:format("[~s] user left~n", [RoomName]),
    room(RoomName, Pids -- [Pid])
end.

user_not_auth(Sock, RoomManager) ->
receive
    {tcp, _, Data} ->
    case string:split(Data," ", all) of
        ["/create", User, Pass] -> 
        case login_manager:create_Account(User, Pass) of 
            ok -> 
            login_manager:login(User, Pass),
            Room = getRoom(RoomManager, "general"),
            Room ! {enter, self()},
            user_auth(Sock, "general", Room, User, RoomManager);
            _ ->
            gen_tcp:send(Sock, "Create acc error"),
            user_not_auth(Sock, RoomManager) 
        end;

        ["/login", User, Pass] ->
        case login_manager:login(User, Pass) of 
            ok ->
            Room = getRoom(RoomManager, "general"),
            Room ! {enter, self()},
            user_auth(Sock, "general", Room, User, RoomManager);
            _ ->
            gen_tcp:send(Sock, "Invalid User/Pass"),
            user_not_auth(Sock, RoomManager)
        end;

        _ -> gen_tcp:send(Sock, "Need to create user or authenticate"),
        user_not_auth(Sock, RoomManager)
    end;
    {tcp_closed, _} ->
    ok;
    {tcp_error, _, _} ->
    ok
end.

user_auth(Sock, RoomName,RoomPid,MyUser,RoomManager) ->
receive
    {line, User, RN, Data} ->
    gen_tcp:send(Sock, ["room:", RN, " ", "user: ", User, ": ", Data]),
    user_auth(Sock, RoomName, RoomPid, MyUser, RoomManager);
    {tcp, _, Data} ->
    case string:split(Data, " ", all) of
        ["/join", NewRoomName] ->
        RoomPid ! {leave, self()},
        NewRoomPid = getRoom(RoomManager, NewRoomName),
        NewRoomPid ! {enter, self()},
        user_auth(Sock, NewRoomName, NewRoomPid, MyUser, RoomManager);
        _ ->
        RoomPid ! {line, MyUser, Data},
        user_auth(Sock, RoomName, RoomPid, MyUser, RoomManager)
    end;
    {tcp_closed, _} ->
    RoomPid ! {leave, self()};
    {tcp_error, _, _} ->
    RoomPid ! {leave, self()}
end.