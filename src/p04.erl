-module(p04).
-export([len/1]).

len([]) ->
    0;
len([_|T]) ->
    len(T)+1.



%%P04 (*) Посчитать количество элементов списка:
%%Пример:
%%1> p04:len([]).
%%0
%%2> p04:len([a,b,c,d]).
%%4




-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
len_test_() -> [
?_assert(len([]) =:= 0),
?_assert(len([a,b,c,d]) =:= 4)
].
-endif.
