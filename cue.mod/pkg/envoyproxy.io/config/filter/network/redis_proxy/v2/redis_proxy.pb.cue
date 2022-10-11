package v2

import (
	core "envoyproxy.io/api/v2/core"
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

// [#next-free-field: 7]
#RedisProxy: {
	"@type": "type.googleapis.com/envoy.config.filter.network.redis_proxy.v2.RedisProxy"
	// The prefix to use when emitting :ref:`statistics <config_network_filters_redis_proxy_stats>`.
	stat_prefix?: string
	// Name of cluster from cluster manager. See the :ref:`configuration section
	// <arch_overview_redis_configuration>` of the architecture overview for recommendations on
	// configuring the backing cluster.
	//
	// .. attention::
	//
	//   This field is deprecated. Use a :ref:`catch_all
	//   route<envoy_api_field_config.filter.network.redis_proxy.v2.RedisProxy.PrefixRoutes.catch_all_route>`
	//   instead.
	//
	// Deprecated: Do not use.
	cluster?: string
	// Network settings for the connection pool to the upstream clusters.
	settings?: #RedisProxy_ConnPoolSettings
	// Indicates that latency stat should be computed in microseconds. By default it is computed in
	// milliseconds.
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
	//    prefix_routes:
	//      routes:
	//        - prefix: "ab"
	//          cluster: "cluster_a"
	//        - prefix: "abc"
	//          cluster: "cluster_b"
	//
	// When using the above routes, the following prefixes would be sent to:
	//
	// * ``get abc:users`` would retrieve the key 'abc:users' from cluster_b.
	// * ``get ab:users`` would retrieve the key 'ab:users' from cluster_a.
	// * ``get z:users`` would return a NoUpstreamHost error. A :ref:`catch-all
	//   route<envoy_api_field_config.filter.network.redis_proxy.v2.RedisProxy.PrefixRoutes.catch_all_route>`
	//   would have retrieved the key from that cluster instead.
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
	downstream_auth_password?: core.#DataSource
}

// RedisProtocolOptions specifies Redis upstream protocol options. This object is used in
// :ref:`typed_extension_protocol_options<envoy_api_field_Cluster.typed_extension_protocol_options>`,
// keyed by the name `envoy.filters.network.redis_proxy`.
#RedisProtocolOptions: {
	"@type": "type.googleapis.com/envoy.config.filter.network.redis_proxy.v2.RedisProtocolOptions"
	// Upstream server password as defined by the `requirepass` directive
	// <https://redis.io/topics/config>`_ in the server's configuration file.
	auth_password?: core.#DataSource
}

// Redis connection pool settings.
// [#next-free-field: 9]
#RedisProxy_ConnPoolSettings: {
	"@type": "type.googleapis.com/envoy.config.filter.network.redis_proxy.v2.RedisProxy_ConnPoolSettings"
	// Per-operation timeout in milliseconds. The timer starts when the first
	// command of a pipeline is written to the backend connection. Each response received from Redis
	// resets the timer since it signifies that the next command is being processed by the backend.
	// The only exception to this behavior is when a connection to a backend is not yet established.
	// In that case, the connect timeout on the cluster will govern the timeout until the connection
	// is ready.
	op_timeout?: string
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
	// Maximum size of encoded request buffer before flush is triggered and encoded requests
	// are sent upstream. If this is unset, the buffer flushes whenever it receives data
	// and performs no batching.
	// This feature makes it possible for multiple clients to send requests to Envoy and have
	// them batched- for example if one is running several worker processes, each with its own
	// Redis connection. There is no benefit to using this with a single downstream process.
	// Recommended size (if enabled) is 1024 bytes.
	max_buffer_size_before_flush?: uint32
	// The encoded request buffer is flushed N milliseconds after the first request has been
	// encoded, unless the buffer size has already exceeded `max_buffer_size_before_flush`.
	// If `max_buffer_size_before_flush` is not set, this flush timer is not used. Otherwise,
	// the timer should be set according to the number of clients, overall request rate and
	// desired maximum latency for a single command. For example, if there are many requests
	// being batched together at a high rate, the buffer will likely be filled before the timer
	// fires. Alternatively, if the request rate is lower the buffer will not be filled as often
	// before the timer fires.
	// If `max_buffer_size_before_flush` is set, but `buffer_flush_timeout` is not, the latter
	// defaults to 3ms.
	buffer_flush_timeout?: string
	// `max_upstream_unknown_connections` controls how many upstream connections to unknown hosts
	// can be created at any given time by any given worker thread (see `enable_redirection` for
	// more details). If the host is unknown and a connection cannot be created due to enforcing
	// this limit, then redirection will fail and the original redirection error will be passed
	// downstream unchanged. This limit defaults to 100.
	max_upstream_unknown_connections?: uint32
	// Enable per-command statistics per upstream cluster, in addition to the filter level aggregate
	// count.
	enable_command_stats?: bool
	// Read policy. The default is to read from the primary.
	read_policy?: #RedisProxy_ConnPoolSettings_ReadPolicy
}

#RedisProxy_PrefixRoutes: {
	"@type": "type.googleapis.com/envoy.config.filter.network.redis_proxy.v2.RedisProxy_PrefixRoutes"
	// List of prefix routes.
	routes?: [...#RedisProxy_PrefixRoutes_Route]
	// Indicates that prefix matching should be case insensitive.
	case_insensitive?: bool
	// Optional catch-all route to forward commands that doesn't match any of the routes. The
	// catch-all route becomes required when no routes are specified.
	// .. attention::
	//
	//   This field is deprecated. Use a :ref:`catch_all
	//   route<envoy_api_field_config.filter.network.redis_proxy.v2.RedisProxy.PrefixRoutes.catch_all_route>`
	//   instead.
	//
	// Deprecated: Do not use.
	catch_all_cluster?: string
	// Optional catch-all route to forward commands that doesn't match any of the routes. The
	// catch-all route becomes required when no routes are specified.
	catch_all_route?: #RedisProxy_PrefixRoutes_Route
}

#RedisProxy_PrefixRoutes_Route: {
	"@type": "type.googleapis.com/envoy.config.filter.network.redis_proxy.v2.RedisProxy_PrefixRoutes_Route"
	// String prefix that must match the beginning of the keys. Envoy will always favor the
	// longest match.
	prefix?: string
	// Indicates if the prefix needs to be removed from the key when forwarded.
	remove_prefix?: bool
	// Upstream cluster to forward the command to.
	cluster?: string
	// Indicates that the route has a request mirroring policy.
	request_mirror_policy?: [...#RedisProxy_PrefixRoutes_Route_RequestMirrorPolicy]
}

// The router is capable of shadowing traffic from one cluster to another. The current
// implementation is "fire and forget," meaning Envoy will not wait for the shadow cluster to
// respond before returning the response from the primary cluster. All normal statistics are
// collected for the shadow cluster making this feature useful for testing.
#RedisProxy_PrefixRoutes_Route_RequestMirrorPolicy: {
	"@type": "type.googleapis.com/envoy.config.filter.network.redis_proxy.v2.RedisProxy_PrefixRoutes_Route_RequestMirrorPolicy"
	// Specifies the cluster that requests will be mirrored to. The cluster must
	// exist in the cluster manager configuration.
	cluster?: string
	// If not specified or the runtime key is not present, all requests to the target cluster
	// will be mirrored.
	//
	// If specified, Envoy will lookup the runtime key to get the percentage of requests to the
	// mirror.
	runtime_fraction?: core.#RuntimeFractionalPercent
	// Set this to TRUE to only mirror write commands, this is effectively replicating the
	// writes in a "fire and forget" manner.
	exclude_read_commands?: bool
}
