-module(p05).
-export([reverse/1]).


reverse(List) ->
    reverse(List, []).


reverse([], Result) ->
    Result;
reverse([H|T], Result) ->
    reverse(T, [H|Result]).





%%P05 (*) Перевернуть список:
%%Пример:
%%1> p05:reverse([1,2,3]).
%%[3,2,1]



-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
reverse_test_() -> [
?_assert(reverse([1,2,3]) =:= [3,2,1])
].
-endif.
