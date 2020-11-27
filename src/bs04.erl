-module(bs04).
-export([decode/2]).


decode(BinText, map) ->
    {Result, <<>>} = parse_object(BinText),
    Result.


parse_code(<<"\"", _/binary>> = BinText) ->
    {Str, Rest} = parse_string(BinText),
    {string, Str, Rest};
parse_code(<<Value, _/binary>> = BinText) when Value >= 48, Value =< 57 ->
    {IntegerValue, ParseRest} = parse_number(BinText, <<>>),
    {number, IntegerValue, ParseRest};
parse_code(<<"{", _/binary>> = BinText) ->
    {ObjectValue, ParseRest} = parse_object(BinText),
    {object, ObjectValue, ParseRest};
parse_code(<<"[", _/binary>> = BinText) ->
    {ArrayValue, ParseRest} = parse_array(BinText),
    {array, ArrayValue, ParseRest};
parse_code(<<"true", Rest/binary>>) ->
    {boolean, true, Rest};
parse_code(<<"false", Rest/binary>>) ->
    {boolean, false, Rest};
parse_code(<<"null", Rest/binary>>) ->
    {null, nil, Rest}.

parse_string(<<"\"", _/binary>> = BinText) ->
    parse_string(BinText, nil).

parse_string(<<"\"", Rest/binary>>, nil) ->
    parse_string(Rest, <<>>);
parse_string(<<"\"", Rest/binary>>, Acc) ->
    {Acc, Rest};
parse_string(<<Char/utf8, Rest/binary>>, Acc) ->
    parse_string(Rest, <<Acc/binary, Char/utf8>>).


parse_number(<<Value, Rest/binary>>, Acc) when Value >= 48, Value =< 57 ->
    parse_number(Rest, <<Acc/binary, Value>>);
parse_number(BinText, Acc) ->
    {binary_to_integer(Acc), BinText}.


parse_key_and_value(<<"\"", _/binary>> = BinText) ->
    parse_key_and_value(BinText, <<>>, <<>>, false).

parse_key_and_value(<<"\"", _/binary>> = BinText, <<>>, <<>>, false) ->
    % Parse key
    {Str, ParseStringRest} = parse_string(BinText),
    parse_key_and_value(ParseStringRest, Str, <<>>, false);
parse_key_and_value(<<":", Rest/binary>>, Key, <<>>, false) ->
    parse_key_and_value(Rest, Key, <<>>, true);
parse_key_and_value(<<" ", Rest/binary>>, Key, Value, IsColonFound) ->
    parse_key_and_value(Rest, Key, Value, IsColonFound);
parse_key_and_value(BinText, Key, <<>>, true) ->
    % Parse value
    {_Type, Value, ParseValueRest} = parse_code(BinText),
    {Key, Value, ParseValueRest}.


parse_object(<<"{", Rest/binary>>) ->
    parse_object(Rest, #{}).

parse_object(<<"}", Rest/binary>>, Acc) ->
    {Acc, Rest};
parse_object(<<"\n", Rest/binary>>, Acc) ->
    parse_object(Rest, Acc);
parse_object(<<" ", Rest/binary>>, Acc) ->
    parse_object(Rest, Acc);
parse_object(<<",", Rest/binary>>, Acc) ->
    parse_object(Rest, Acc);
parse_object(<<"\"", _/binary>> = BinText, Acc) ->
    {Key, Value, ParseRest} = parse_key_and_value(BinText),
    parse_object(ParseRest, maps:put(Key, Value, Acc)).

parse_array(<<"[", Rest/binary>>) ->
    {List, ParseRest} = parse_array(Rest, []),
    {lists:reverse(List), ParseRest}.

parse_array(<<"]", Rest/binary>>, Acc) ->
    {Acc, Rest};
parse_array(<<"\n", Rest/binary>>, Acc) ->
    parse_array(Rest, Acc);
parse_array(<<" ", Rest/binary>>, Acc) ->
    parse_array(Rest, Acc);
parse_array(<<",", Rest/binary>>, Acc) ->
    parse_array(Rest, Acc);
parse_array(BinText, Acc) ->
    {_Type, Value, ParseValueRest} = parse_code(BinText),
    parse_array(ParseValueRest, [Value|Acc]).




%%BS04: Разобрать JSON:
%%Пример:
%%1> Json = <<"
%%1> {
%%1>
%%'squadName': 'Super hero squad',
%%1>
%%'homeTown': 'Metro City',
%%1>
%%'formed': 2016,
%%1>
%%'secretBase': 'Super tower',
%%1>
%%'active': true,
%%1>
%%'members': [
%%1>
%%{
%%1>
%%'name': 'Molecule Man',
%%1>
%%'age': 29,
%%1>
%%'secretIdentity': 'Dan Jukes',
%%1>
%%'powers': [
%%1>
%%'Radiation resistance',
%%1>
%%'Turning tiny',
%%1>
%%'Radiation blast'
%%1>
%%]
%%1>
%%},
%%1>
%%{
%%1>
%%'name': 'Madame Uppercut',
%%1>
%%'age': 39,
%%1>
%%'secretIdentity': 'Jane Wilson',
%%1>
%%'powers': [
%%1>
%%'Million tonne punch',
%%1>
%%'Damage resistance',
