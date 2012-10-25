-module(amazon_lib).
-export([start/0, stop/0, start/1, stop/1, info/0]).

-export([init_ec2conn/0]).

-include_lib("erlcloud/include/erlcloud.hrl").
-include_lib("erlcloud/include/erlcloud_ec2.hrl").

init_ec2conn() ->
    ApiKey = get_env(api_key),
    SecretKey = get_env(secret_key),
    erlcloud_ec2:new(ApiKey, SecretKey).

start() ->
    erlcloud_ec2:start_instances(get_env(instance_ids), init_ec2conn()).

start(N) ->
    erlcloud_ec2:start_instances([lists:nth(N, get_env(instance_ids))], init_ec2conn()).

stop() ->
    erlcloud_ec2:stop_instances(get_env(instance_ids), init_ec2conn()).

stop(N) ->
    erlcloud_ec2:stop_instances([lists:nth(N, get_env(instance_ids))], init_ec2conn()).

get_env(Id) ->
    {ok, Value} = application:get_env(?MODULE, Id),
    Value.

info() ->
    erlcloud_ec2:describe_instances(get_env(instance_ids), init_ec2conn()).
