-module(p13).
-export([decode/1]).

decode(L) ->
    p05:reverse(decode(L, [])).

decode([], Acc) ->
    Acc;

decode([{}|T], Acc) ->
    decode(T, Acc);

decode([{_A}|T], Acc) ->
    decode(T, Acc);

decode([H|T], Acc) -> 
	{A,B}=H, 
	G = p15:replicate([B],A), 
	decode(T,  G ++ Acc).





%%P13 (**) Написать декодер для стандартного алгоритма RLE:
%%Пример:
%%1> p13:decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]).
%%[a,a,a,a,b,c,c,a,a,d,e,e,e,e]




-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
decode_test_() -> [
?_assert(decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]) =:= [a,a,a,a,b,c,c,a,a,d,e,e,e,e])
].
-endif.
