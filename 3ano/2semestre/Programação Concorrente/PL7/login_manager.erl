-module(login_manager).
-export([close_account/2, 
        close_account/2, 
        login/2, 
        login/1, 
        online/0]).

% interface functions 

start() -> 
    Pid = spawn(fun() -> loop(#{},0) end),
    register(?MODULE , Pid)

rpc(Request) ->
    ?MODULE !  | {Request, self()},
    receive {?MODULE, Res} -> Res end. 

% create_account(Username, Passwd) -> 
%     ?MODULE !  | {create_account, Username, Passwd, self()},
%     receive {?MODULE, Res} -> Res end. 

% close_account(Username, Passwd) ->
%     ?MODULE !  | {close_account, Username, Passwd, self()},
%     receive {?MODULE, Res} -> Res end. 

% login(Username, Passwd) -> 
%     ?MODULE !  | {login, Username, Passwd, self()},
%     receive {?MODULE, Res} -> Res end. 

% logout(Username) -> 
%     ?MODULE !  | {logout, Username, self()},
%     receive {?MODULE, Res} -> Res end. 

% online() ->
%     ?MODULE ! | {online, self()},
%     receive {?MODULE, Res} -> Res end. 


create_account(Username, Passwd) -> rpc({create_account,Username,Passwd})

close_account(Username, Passwd) -> rpc({close_account,Username,Passwd})

login(Username, Passwd) -> rpc({login,Username,Passwd})

logout(Username) -> rpc({logout,Username})

online() -> rpc({online})


% ISTO É TOP
loop(State) -> 
    receive
        {Request, From} -> 
            {Res, NextState} = handle(Request, State),
            From ! {?MODULE, Res},
            loop(NextState)
end.

%preguiça


% server loop

loop(Map) ->
    receive
        {{create_account, Username, Passwd}, From} ->
            case maps:find(Username,Map) of
                error -> 
                    From ! {?MODULE, ok},
                    loop(maps:put(Username, {Passwd,true},Map));

                {ok, _} -> 
                    From ! {?MODULE, user_exists},
                    loop(Map)

            end;

        {{close_account, Username, Passwd}, From} ->
            case maps:find(Username,Map) of
                
                {ok, {Passwd,_}} ->             
                    From ! {?MODULE, ok},
                    loop(maps:remove(Username,Map));
                
                _ -> 
                    From ! {?MODULE, invalid},
                    loop(Map)
            end;

        {{login, Username, Passwd}, From} ->
            case maps:find(Username,Map) of
                
                {ok, {Passwd, false}} ->             
                    From ! {?MODULE, ok},
                    loop(maps:put(Username,{Passwd,true},Map));
                _ -> 
                    From ! {?MODULE, invalid},
                    loop(Map)
            end;

        {{logout, Username}, From} ->
            case maps:find(Username,Map) of
                {ok, {Passwd,_}} -> 
                    From ! {?MODULE, ok},
                    loop(maps:put(Username, {Passwd,false},Map));

                _ -> 
                    From ! {?MODULE, ok},
                    loop(Map)

            end;
        
        {online, From} ->
            Users = [User || {User,{_,true}} <- maps:to_list(Map)],
            fold = (lambda )
            From ! {?MODULE, Users},
            loop(Map)

        

end.
