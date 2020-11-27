-module(p03).
-export([element_at/2]).

element_at([H|_],1) ->
    H;
element_at([_|T],X) ->
    element_at(T,X-1);
element_at([],_) ->
    undefined.




%%P03 (*) Найти N-й элемент списка:
%%Пример:
%%1> p03:element_at([a,b,c,d,e,f], 4).
%%d
%%2> p03:element_at([a,b,c,d,e,f], 10).
%%undefined




-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
element_at_test_() -> [
?_assert(element_at([a,b,c,d,e,f], 4) =:= d),
?_assert(element_at([a,b,c,d,e,f], 10) =:= undefined)
].
-endif.
