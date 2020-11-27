-module(p10).
-export([encode/1]).

encode(List)->
  PackedList= p09:pack(List),
  p05:reverse(encode(PackedList, [])).

encode([], Result)->
  Result;

encode([H|T], Result)->
  encode(T, [{p04:len(H), p03:element_at(H, 1)}|Result]).



%%P10 (**) Закодировать список с использованием алгоритма RLE:
%%Пример:
%%1> p10:encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%%[{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]




-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
encode_test_() -> [
?_assert(encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e]) =:= [{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}])
].
-endif.
