-module(p08).
-export([compress/1]).

compress(L) ->
    p05:reverse(compress(L, [])).

compress([], Acc) ->
    Acc;

compress([H | []], Acc) ->
    [H | Acc];

compress([A,A | T], Acc) ->
    G=[A|T], compress(G, Acc);

compress([H | T], Acc) ->
    compress(T, [H | Acc]).




%%P08 (**) Удалить последовательно следующие дубликаты:
%%Пример:
%%1> p08:compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%%[a,b,c,a,d,e].




-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
compress_test_() -> [
?_assert(compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e]) =:= [a,b,c,a,d,e])
].
-endif.
