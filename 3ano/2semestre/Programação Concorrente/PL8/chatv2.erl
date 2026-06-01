-module(chatv2).
-export([start/1, stop/1]).

start(Port) -> spawn(fun() -> server(Port) end).

stop(Server) -> Server ! stop.

getRoom(RoomManager,Name) -> 
  spawn(fun() -> room([]) end)
  .


room_manager() ->
  receive

    end.


server(Port) ->
  {ok, LSock} = gen_tcp:listen(Port, [binary, {packet, line}, {reuseaddr, true}]),
  Room = spawn(fun()-> room([]) end),
  spawn(fun() -> acceptor(LSock, Room) end),
  receive stop -> ok end.

acceptor(LSock, Room) ->
  {ok, Sock} = gen_tcp:accept(LSock),
  spawn(fun() -> acceptor(LSock, Room) end),
  Room ! {enter, self()},
  user(Sock, Room).

room(Pids) ->
  receive
    {enter, Pid} ->
      io:format("user entered~n", []),
      room([Pid | Pids]);
    {line, Data} = Msg ->
      io:format("received ~p~n", [Data]),
      [Pid ! Msg || Pid <- Pids],
      room(Pids);
    {leave, Pid} ->
      io:format("user left~n", []),
      room(Pids -- [Pid])
  end.

user(Sock, RoomManager) ->
  receive
    {line, MsgUser, Data} ->
      gen_tcp:send(Sock, [RoomName,":",MsgUser,": ",Data]),
      user(Sock, Room);
    {tcp, _, Data} ->
      split 
      Room = getRoom(RoomManager,"principal"),
      Room ! {line, Data},
       user(Sock, Room);
    {tcp_closed, _} ->
      Room ! {leave, self()};
    {tcp_error, _, _} ->
      Room ! {leave, self()}
  end.

