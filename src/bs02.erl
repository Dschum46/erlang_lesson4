-module(bs02).
-export([words/1]).

words(Bin) ->
    lists:reverse(words(Bin, <<>>, [])).
words(<<" ", Rest/binary>>, Accbin, Acc) ->
    words(Rest, <<>>, [Accbin | Acc]);
words(<<X, Rest/binary>>, Accbin, Acc) -> 
    words(Rest, <<Accbin/binary, X>>, Acc);
words(<<>>, Accbin, Acc) ->
    [Accbin | Acc].



%%BS02: Разделить строку на слова:
%%Пример:
%%2> bs02:words(<<"Text with four words">>).
%%[<<"Text">>, <<"with">>, <<"four">>, <<"words">>]




-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
words_test_() -> [
?_assert(words(<<"Text with four words">>) =:= [<<"Text">>, <<"with">>, <<"four">>, <<"words">>]),
?_assert(words(<<"Some three words">>) =:= [<<"Some">>, <<"three">>, <<"words">>]),
?_assert(words(<<"word">>) =:= [<<"word">>])
].
-endif.
