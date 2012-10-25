-module(amazon_lib_sdb).
-export([init/0, lists/0, put/2, get/1, delete/1]).
-define(DOMAIN, "cloud").

init() ->
    EC2 = amazon_lib:init_ec2conn(),
    erlcloud_sdb:create_domain(?DOMAIN, EC2).

lists() ->
    EC2 = amazon_lib:init_ec2conn(),
    erlcloud_sdb:list_domains(EC2).

put(Key, Attributes) ->
    EC2 = amazon_lib:init_ec2conn(),
    erlcloud_sdb:put_attributes(?DOMAIN, Key, Attributes, [], EC2).

get(Key) ->
    case Key =/= "" of
        true ->
            EC2 = amazon_lib:init_ec2conn(),
            erlcloud_sdb:get_attributes(?DOMAIN, Key, EC2);
        false ->
            [{attributes,[]}, undefined]
    end.

delete(Key) ->
    EC2 = amazon_lib:init_ec2conn(),
    erlcloud_sdb:delete_attributes(?DOMAIN, Key, EC2).

