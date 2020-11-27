-module(p06).
-export([is_polindrome/1]).

is_polindrome(L) ->
    is_polindrome(L,L,[]).

is_polindrome(K,[H|T], Acc) ->
    is_polindrome(K,T, [H]++Acc);

is_polindrome([],[], _Acc) ->
    false;

is_polindrome([_H|[]],[], _Acc) ->
    false;

is_polindrome(K,[], Acc) ->
    K=:=Acc.



%%P06 (*) Определить, является ли список палиндромом:
%%Пример:
%%1> p06:is_polindrome([1,2,3,2,1]).
%%true



-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
is_polindrome_test_() -> [
?_assert(is_polindrome([1,2,3,2,1]) =:= true)
].
-endif.
