-module(p15).
-export([replicate/2]).

replicate(L, Koef) ->
    p05:reverse(replicate(L, Koef, Koef, [])).

replicate([], _, _, Acc) ->
    Acc;

replicate([_H | T], Koef, 0, Acc) ->
    replicate(T, Koef, Koef, Acc);

replicate([H | _T] = G, Koef, K, Acc) ->
    replicate(G, Koef, K-1, [H | Acc]).






%%P15 (**) Написать функцию-репликатор всех элементов входящего списка:
%%Пример:
%%1> p15:replicate([a,b,c], 3).
%%[a,a,a,b,b,b,c,c,c]




-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
replicate_test_() -> [
?_assert(replicate([a,b,c], 3) =:= [a,a,a,b,b,b,c,c,c])
].
-endif.
