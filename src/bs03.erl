-module(bs03).
-export([split/2]).


split(BinText, Sep) -> 
    BinSep = list_to_binary(Sep),
    Size = byte_size(BinSep),
    split(BinText, BinSep, Size, <<>>, []).
split(Bin, Sep, Size, Word, Acc) ->
    case Bin of
    <<Sep:Size/binary, Rest/binary>> ->
    split(Rest, Sep, Size, <<>>, [Word|Acc]);
    <<C/utf8, Rest/binary>> ->
    split(Rest, Sep, Size, <<Word/binary, C/utf8>>, Acc);
    <<>> ->
    lists:reverse([Word|Acc])
    end.


%%BS03: Разделить строку на части, с явным указанием разделителя:
%%Пример:
%%1> BinText = <<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>.
%%<<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>
%%2> bs03:split(BinText, “-:-”).
%%[<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>]



-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

split_test_() -> [
    ?_assert(split(<<>>, " ") =:= [<<>>]),
    ?_assert(split(<<" ">>, " ") =:= [<<>>, <<>>]),
    ?_assert(split(<<"Hello-world!">>, "-") =:= [<<"Hello">>, <<"world!">>])
].
-endif.
