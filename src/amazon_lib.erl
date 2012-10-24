-module(amazon_lib).
-export([start/2, stop/1]).
-export([start/0, stop/0, info/0]).

-export([init_ec2conn/0]).

-include_lib("erlcloud/include/erlcloud.hrl").
-include_lib("erlcloud/include/erlcloud_ec2.hrl").


init_ec2conn() ->
    ApiKey = get_env(api_key),
    SecretKey = get_env(secret_key),
    erlcloud_ec2:new(ApiKey, SecretKey).

start(_, _) ->
    {ok, self()}.

stop(_) ->
    ok.

start() ->
    EC2 = init_ec2conn(),
    InstanceIDs = get_env(instance_ids),
    erlcloud_ec2:start_instances(InstanceIDs, EC2).

stop() ->
    EC2 = init_ec2conn(),
    InstanceIDs = get_env(instance_ids),
    erlcloud_ec2:stop_instances(InstanceIDs, EC2).

get_env(Id) ->
    {ok, Value} = application:get_env(?MODULE, Id),
    Value.

info() ->
    EC2 = init_ec2conn(),
    InstanceIDs = get_env(instance_ids),
    erlcloud_ec2:describe_instances(InstanceIDs, EC2).
