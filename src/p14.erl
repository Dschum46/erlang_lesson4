-module(p14).
-export([duplicate/1]).

duplicate(List)->
  p15:replicate(List, 2).



%%P14 (*) Написать дубликатор всех элементов входящего списка:
%%Пример:
%%1> p14:duplicate([a,b,c,c,d]).
%%[a,a,b,b,c,c,c,c,d,d]






-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
duplicate_test_() -> [
?_assert(duplicate([a,b,c,c,d]) =:= [a,a,b,b,c,c,c,c,d,d])
].
-endif.
