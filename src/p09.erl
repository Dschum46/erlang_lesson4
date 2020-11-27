-module(p09).
-export([pack/1]).

pack(L) ->
    p05:reverse(pack(L, [], [])).

pack([], _Acc, Acc1) ->
    Acc1;

pack([A,A|T], Acc, Acc1) ->
    pack([A|T], [A|Acc], Acc1);

pack([H|T], Acc, Acc1) ->
    G = [H|Acc],
    pack(T, [], [G|Acc1]).


%%P09 (**) Запаковать последовательно следующие дубликаты во вложеные списки:
%%Пример:
%%1> p09:.
%%[[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]].




-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
reverse_test_() -> [
?_assert(pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e]) =:= [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]])
].
-endif.
