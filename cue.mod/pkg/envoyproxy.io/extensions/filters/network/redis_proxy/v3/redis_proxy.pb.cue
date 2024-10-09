package v3

import (
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
	v3 "envoyproxy.io/config/core/v3"
	v31 "envoyproxy.io/extensions/common/dynamic_forward_proxy/v3"
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

// ReadPolicy controls how Envoy routes read commands to Redis nodes. This is currently
// supported for Redis Cluster. All ReadPolicy settings except MASTER may return stale data
// because replication is asynchronous and requires some delay. You need to ensure that your
// application can tolerate stale data.
#RedisProxy_ConnPoolSettings_ReadPolicy: "MASTER" | "PREFER_MASTER" | "REPLICA" | "PREFER_REPLICA" | "ANY"

RedisProxy_ConnPoolSettings_ReadPolicy_MASTER:         "MASTER"
RedisProxy_ConnPoolSettings_ReadPolicy_PREFER_MASTER:  "PREFER_MASTER"
RedisProxy_ConnPoolSettings_ReadPolicy_REPLICA:        "REPLICA"
RedisProxy_ConnPoolSettings_ReadPolicy_PREFER_REPLICA: "PREFER_REPLICA"
RedisProxy_ConnPoolSettings_ReadPolicy_ANY:            "ANY"

#RedisProxy_RedisFault_RedisFaultType: "DELAY" | "ERROR"

RedisProxy_RedisFault_RedisFaultType_DELAY: "DELAY"
RedisProxy_RedisFault_RedisFaultType_ERROR: "ERROR"

// [#next-free-field: 11]
#RedisProxy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.redis_proxy.v3.RedisProxy"
	// The prefix to use when emitting :ref:`statistics <config_network_filters_redis_proxy_stats>`.
	stat_prefix?: string
	// Network settings for the connection pool to the upstream clusters.
	settings?: #RedisProxy_ConnPoolSettings
	// Indicates that latency stat should be computed in microseconds. By default it is computed in
	// milliseconds. This does not apply to upstream command stats currently.
	latency_in_micros?: bool
	// List of **unique** prefixes used to separate keys from different workloads to different
	// clusters. Envoy will always favor the longest match first in case of overlap. A catch-all
	// cluster can be used to forward commands when there is no match. Time complexity of the
	// lookups are in O(min(longest key prefix, key length)).
	//
	// Example:
	//
	// .. code-block:: yaml
	//
	//	prefix_routes:
	//	  routes:
	//	    - prefix: "ab"
	//	      cluster: "cluster_a"
	//	    - prefix: "abc"
	//	      cluster: "cluster_b"
	//
	// When using the above routes, the following prefixes would be sent to:
	//
	//   - “get abc:users“ would retrieve the key 'abc:users' from cluster_b.
	//   - “get ab:users“ would retrieve the key 'ab:users' from cluster_a.
	//   - “get z:users“ would return a NoUpstreamHost error. A :ref:`catch-all
	//     route<envoy_v3_api_field_extensions.filters.network.redis_proxy.v3.RedisProxy.PrefixRoutes.catch_all_route>`
	//     would have retrieved the key from that cluster instead.
	//
	// See the :ref:`configuration section
	// <arch_overview_redis_configuration>` of the architecture overview for recommendations on
	// configuring the backing clusters.
	prefix_routes?: #RedisProxy_PrefixRoutes
	// Authenticate Redis client connections locally by forcing downstream clients to issue a `Redis
	// AUTH command <https://redis.io/commands/auth>`_ with this password before enabling any other
	// command. If an AUTH command's password matches this password, an "OK" response will be returned
	// to the client. If the AUTH command password does not match this password, then an "ERR invalid
	// password" error will be returned. If any other command is received before AUTH when this
	// password is set, then a "NOAUTH Authentication required." error response will be sent to the
	// client. If an AUTH command is received when the password is not set, then an "ERR Client sent
	// AUTH, but no password is set" error will be returned.
	//
	// .. attention::
	//
	//	This field is deprecated. Use :ref:`downstream_auth_passwords
	//	<envoy_v3_api_field_extensions.filters.network.redis_proxy.v3.RedisProxy.downstream_auth_passwords>`.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/filters/network/redis_proxy/v3/redis_proxy.proto.
	downstream_auth_password?: v3.#DataSource
	// Authenticate Redis client connections locally by forcing downstream clients to issue a `Redis
	// AUTH command <https://redis.io/commands/auth>`_ with one of these passwords before enabling any other
	// command. If an AUTH command's password matches one of these passwords, an "OK" response will be returned
	// to the client. If the AUTH command password does not match, then an "ERR invalid
	// password" error will be returned. If any other command is received before AUTH when the
	// password(s) are set, then a "NOAUTH Authentication required." error response will be sent to the
	// client. If an AUTH command is received when the password is not set, then an "ERR Client sent
	// AUTH, but no password is set" error will be returned.
	downstream_auth_passwords?: [...v3.#DataSource]
	// List of faults to inject. Faults currently come in two flavors:
	// - Delay, which delays a request.
	// - Error, which responds to a request with an error. Errors can also have delays attached.
	//
	// Example:
	//
	// .. code-block:: yaml
	//
	//	faults:
	//	- fault_type: ERROR
	//	  fault_enabled:
	//	    default_value:
	//	      numerator: 10
	//	      denominator: HUNDRED
	//	    runtime_key: "bogus_key"
	//	    commands:
	//	    - GET
	//	  - fault_type: DELAY
	//	    fault_enabled:
	//	      default_value:
	//	        numerator: 10
	//	        denominator: HUNDRED
	//	      runtime_key: "bogus_key"
	//	    delay: 2s
	//
	// See the :ref:`fault injection section
	// <config_network_filters_redis_proxy_fault_injection>` for more information on how to configure this.
	faults?: [...#RedisProxy_RedisFault]
	// If a username is provided an ACL style AUTH command will be required with a username and password.
	// Authenticate Redis client connections locally by forcing downstream clients to issue a `Redis
	// AUTH command <https://redis.io/commands/auth>`_ with this username and the “downstream_auth_password“
	// before enabling any other command. If an AUTH command's username and password matches this username
	// and the “downstream_auth_password“ , an "OK" response will be returned to the client. If the AUTH
	// command username or password does not match this username or the “downstream_auth_password“, then an
	// "WRONGPASS invalid username-password pair" error will be returned. If any other command is received before AUTH when this
	// password is set, then a "NOAUTH Authentication required." error response will be sent to the
	// client. If an AUTH command is received when the password is not set, then an "ERR Client sent
	// AUTH, but no ACL is set" error will be returned.
	downstream_auth_username?: v3.#DataSource
	// External authentication configuration. If set, instead of validating username and password against “downstream_auth_username“ and “downstream_auth_password“,
	// the filter will call an external gRPC service to authenticate the client.
	// A typical usage of this feature is for situations where the password is a one-time token that needs to be validated against a remote service, like a sidecar.
	// Expiration is also supported, which will disable any further commands from the client after the expiration time, unless a new AUTH command is received and the external auth service returns a new expiration time.
	// If the external auth service returns an error, authentication is considered failed.
	// If this setting is set together with “downstream_auth_username“ and “downstream_auth_password“, the external auth service will be source of truth, but those fields will still be used for downstream authentication to the cluster.
	// The API is defined by :ref:`RedisProxyExternalAuthRequest <envoy_v3_api_msg_service.redis_auth.v3.RedisProxyExternalAuthRequest>`.
	external_auth_provider?: #RedisExternalAuthProvider
}

// RedisProtocolOptions specifies Redis upstream protocol options. This object is used in
// :ref:`typed_extension_protocol_options<envoy_v3_api_field_config.cluster.v3.Cluster.typed_extension_protocol_options>`,
// keyed by the name “envoy.filters.network.redis_proxy“.
#RedisProtocolOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.redis_proxy.v3.RedisProtocolOptions"
	// Upstream server password as defined by the “requirepass“ directive
	// `<https://redis.io/topics/config>`_ in the server's configuration file.
	auth_password?: v3.#DataSource
	// Upstream server username as defined by the “user“ directive
	// `<https://redis.io/topics/acl>`_ in the server's configuration file.
	auth_username?: v3.#DataSource
}

// RedisExternalAuthProvider specifies a gRPC service that can be used to authenticate Redis clients.
// This service will be called every time an AUTH command is received from a client.
// If the service returns an error, authentication is considered failed.
// If the service returns a success, the client is considered authenticated.
// The service can also return an expiration timestamp, which will be used to disable any further
// commands from the client after it passes, unless a new AUTH command is received and the
// external auth service returns a new expiration timestamp.
#RedisExternalAuthProvider: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.redis_proxy.v3.RedisExternalAuthProvider"
	// External auth gRPC service configuration.
	// It will be called every time an AUTH command is received from a client.
	grpc_service?: v3.#GrpcService
	// If set to true, the filter will expect an expiration timestamp in the response from the external
	// auth service. This timestamp will be used to disable any further commands from the client after
	// the expiration time, unless a new AUTH command is received and the external auth service returns
	// a new expiration timestamp.
	enable_auth_expiration?: bool
}

// Redis connection pool settings.
// [#next-free-field: 11]
#RedisProxy_ConnPoolSettings: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.redis_proxy.v3.RedisProxy_ConnPoolSettings"
	// Per-operation timeout in milliseconds. The timer starts when the first
	// command of a pipeline is written to the backend connection. Each response received from Redis
	// resets the timer since it signifies that the next command is being processed by the backend.
	// The only exception to this behavior is when a connection to a backend is not yet established.
	// In that case, the connect timeout on the cluster will govern the timeout until the connection
	// is ready.
	op_timeout?: durationpb.#Duration
	// Use hash tagging on every redis key to guarantee that keys with the same hash tag will be
	// forwarded to the same upstream. The hash key used for determining the upstream in a
	// consistent hash ring configuration will be computed from the hash tagged key instead of the
	// whole key. The algorithm used to compute the hash tag is identical to the `redis-cluster
	// implementation <https://redis.io/topics/cluster-spec#keys-hash-tags>`_.
	//
	// Examples:
	//
	// * '{user1000}.following' and '{user1000}.followers' **will** be sent to the same upstream
	// * '{user1000}.following' and '{user1001}.following' **might** be sent to the same upstream
	enable_hashtagging?: bool
	// Accept `moved and ask redirection
	// <https://redis.io/topics/cluster-spec#redirection-and-resharding>`_ errors from upstream
	// redis servers, and retry commands to the specified target server. The target server does not
	// need to be known to the cluster manager. If the command cannot be redirected, then the
	// original error is passed downstream unchanged. By default, this support is not enabled.
	enable_redirection?: bool
	// If “enable_redirection“ is set to true this option configures the DNS cache that the
	// connection pool will use to resolve hostnames that are returned with MOVED and ASK responses.
	// If no configuration is provided, DNS lookups will not be performed (and thus the MOVED/ASK errors
	// will be propagated verbatim to the user).
	dns_cache_config?: v31.#DnsCacheConfig
	// Maximum size of encoded request buffer before flush is triggered and encoded requests
	// are sent upstream. If this is unset, the buffer flushes whenever it receives data
	// and performs no batching.
	// This feature makes it possible for multiple clients to send requests to Envoy and have
	// them batched- for example if one is running several worker processes, each with its own
	// Redis connection. There is no benefit to using this with a single downstream process.
	// Recommended size (if enabled) is 1024 bytes.
	max_buffer_size_before_flush?: uint32
	// The encoded request buffer is flushed N milliseconds after the first request has been
	// encoded, unless the buffer size has already exceeded “max_buffer_size_before_flush“.
	// If “max_buffer_size_before_flush“ is not set, this flush timer is not used. Otherwise,
	// the timer should be set according to the number of clients, overall request rate and
	// desired maximum latency for a single command. For example, if there are many requests
	// being batched together at a high rate, the buffer will likely be filled before the timer
	// fires. Alternatively, if the request rate is lower the buffer will not be filled as often
	// before the timer fires.
	// If “max_buffer_size_before_flush“ is set, but “buffer_flush_timeout“ is not, the latter
	// defaults to 3ms.
	buffer_flush_timeout?: durationpb.#Duration
	// “max_upstream_unknown_connections“ controls how many upstream connections to unknown hosts
	// can be created at any given time by any given worker thread (see “enable_redirection“ for
	// more details). If the host is unknown and a connection cannot be created due to enforcing
	// this limit, then redirection will fail and the original redirection error will be passed
	// downstream unchanged. This limit defaults to 100.
	max_upstream_unknown_connections?: wrapperspb.#UInt32Value
	// Enable per-command statistics per upstream cluster, in addition to the filter level aggregate
	// count. These commands are measured in microseconds.
	enable_command_stats?: bool
	// Read policy. The default is to read from the primary.
	read_policy?: #RedisProxy_ConnPoolSettings_ReadPolicy
	// Ops or connection timeout triggers reconnection to redis server which could result in reconnection
	// storm to busy redis server. This config is a protection to rate limit reconnection rate.
	// If not set, there will be no rate limiting on the reconnection.
	connection_rate_limit?: #RedisProxy_ConnectionRateLimit
}

#RedisProxy_PrefixRoutes: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.redis_proxy.v3.RedisProxy_PrefixRoutes"
	// List of prefix routes.
	routes?: [...#RedisProxy_PrefixRoutes_Route]
	// Indicates that prefix matching should be case insensitive.
	case_insensitive?: bool
	// Optional catch-all route to forward commands that doesn't match any of the routes. The
	// catch-all route becomes required when no routes are specified.
	catch_all_route?: #RedisProxy_PrefixRoutes_Route
}

// RedisFault defines faults used for fault injection.
#RedisProxy_RedisFault: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.redis_proxy.v3.RedisProxy_RedisFault"
	// Fault type.
	fault_type?: #RedisProxy_RedisFault_RedisFaultType
	// Percentage of requests fault applies to.
	fault_enabled?: v3.#RuntimeFractionalPercent
	// Delay for all faults. If not set, defaults to zero
	delay?: durationpb.#Duration
	// Commands fault is restricted to, if any. If not set, fault applies to all commands
	// other than auth and ping (due to special handling of those commands in Envoy).
	commands?: [...string]
}

// Configuration to limit reconnection rate to redis server to protect redis server
// from client reconnection storm.
#RedisProxy_ConnectionRateLimit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.redis_proxy.v3.RedisProxy_ConnectionRateLimit"
	// Reconnection rate per sec. Rate limiting is implemented with TokenBucket.
	connection_rate_limit_per_sec?: uint32
}

// [#next-free-field: 7]
#RedisProxy_PrefixRoutes_Route: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.redis_proxy.v3.RedisProxy_PrefixRoutes_Route"
	// String prefix that must match the beginning of the keys. Envoy will always favor the
	// longest match.
	prefix?: string
	// Indicates if the prefix needs to be removed from the key when forwarded.
	remove_prefix?: bool
	// Upstream cluster to forward the command to.
	cluster?: string
	// Indicates that the route has a request mirroring policy.
	request_mirror_policy?: [...#RedisProxy_PrefixRoutes_Route_RequestMirrorPolicy]
	// Indicates how redis key should be formatted. To substitute redis key into the formatting
	// expression, use %KEY% as a string replacement command.
	key_formatter?: string
	// Indicates that the route has a read command policy
	read_command_policy?: #RedisProxy_PrefixRoutes_Route_ReadCommandPolicy
}

// The router is capable of shadowing traffic from one cluster to another. The current
// implementation is "fire and forget," meaning Envoy will not wait for the shadow cluster to
// respond before returning the response from the primary cluster. All normal statistics are
// collected for the shadow cluster making this feature useful for testing.
#RedisProxy_PrefixRoutes_Route_RequestMirrorPolicy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.redis_proxy.v3.RedisProxy_PrefixRoutes_Route_RequestMirrorPolicy"
	// Specifies the cluster that requests will be mirrored to. The cluster must
	// exist in the cluster manager configuration.
	cluster?: string
	// If not specified or the runtime key is not present, all requests to the target cluster
	// will be mirrored.
	//
	// If specified, Envoy will lookup the runtime key to get the percentage of requests to the
	// mirror.
	runtime_fraction?: v3.#RuntimeFractionalPercent
	// Set this to TRUE to only mirror write commands, this is effectively replicating the
	// writes in a "fire and forget" manner.
	exclude_read_commands?: bool
}

// ReadCommandPolicy specifies that Envoy should route read commands to another cluster.
#RedisProxy_PrefixRoutes_Route_ReadCommandPolicy: {
	"@type":  "type.googleapis.com/envoy.extensions.filters.network.redis_proxy.v3.RedisProxy_PrefixRoutes_Route_ReadCommandPolicy"
	cluster?: string
}
