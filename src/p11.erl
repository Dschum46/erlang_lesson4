-module(p11).
-export([encode_modified/1]).

encode_modified(L) ->
    p05:reverse(encode_modified(L, 0, [])).

encode_modified([], _Counter, Acc) ->
    Acc;
encode_modified([H|[]], 0, Acc) ->
    encode_modified([], 0, [H|Acc]);
encode_modified([A,A|T], Counter, Acc) ->
    encode_modified([A|T], Counter+1, Acc);
encode_modified([A,B|T], 0, Acc) ->
    encode_modified([B|T], 0, [A|Acc]);
encode_modified([H|T], Counter, Acc) ->
    G = {Counter+1, H}, encode_modified(T, 0, [G|Acc]).




%%P11 (**) Закодировать список с использованием модифицированого алгоритма RLE:
%%Пример:
%%1> p11:encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%%[{4,a},b,{2,c},{2,a},d,{4,e}]



-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
encode_modified_test_() -> [
?_assert(encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e]) =:= [{4,a},b,{2,c},{2,a},d,{4,e}])
].
-endif.
