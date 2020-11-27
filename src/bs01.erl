-module(bs01).
-export([first_word/1]).

first_word(Bin) -> 
    first_word(Bin, <<>>).

first_word(<<" ", _Rest/binary>>, Acc) ->
    Acc;
first_word(<<X, Rest/binary>>, Acc) ->
    first_word(Rest, <<Acc/binary, X>>);
first_word(<<>>, Acc) ->
    Acc.

%%BS01: Извлечь из строки первое слово:
%%Пример:
%%1> BinText = <<"Some text">>.
%%<<"Some Text">>
%%2> bs01:first_word(BinText).
%%<<”Some”>>



-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
first_word_test_() -> [
?_assert(first_word(<<"Some Text">>) =:= <<"Some">>)
].
-endif.
