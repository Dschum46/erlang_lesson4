-module(p12).
-export([decode_modified/1]).

decode_modified(L) ->
    p05:reverse(decode_modified(L, [])).

decode_modified([], Acc) ->
    Acc;

decode_modified([{}|T], Acc) ->
    decode_modified(T, Acc);

decode_modified([{_A}|T], Acc) ->
    decode_modified(T, Acc);

decode_modified([{1,_A}|T], Acc) ->
    decode_modified(T, Acc);

decode_modified([[_|_]|T], Acc) ->
    decode_modified(T, Acc);

decode_modified([{A,B}|T], Acc) -> 
	G = p15:replicate([B],A), 
	decode_modified(T,  G ++ Acc);

decode_modified([H|T], Acc) ->
    decode_modified(T, [H | Acc]).






%%P12 (**) Написать декодер для модифицированого алгоритма RLE:
%%Пример:
%%1> p12:decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}]).
%%[a,a,a,a,b,c,c,a,a,d,e,e,e,e]




-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
decode_modified_test_() -> [
?_assert(decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}]) =:= [a,a,a,a,b,c,c,a,a,d,e,e,e,e])
].
-endif.
