package v2

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
	_type "envoyproxy.io/type"
	auth "envoyproxy.io/api/v2/auth"
	cluster "envoyproxy.io/api/v2/cluster"
	core "envoyproxy.io/api/v2/core"
)

// Refer to :ref:`service discovery type <arch_overview_service_discovery_types>`
// for an explanation on each type.
#Cluster_DiscoveryType: "STATIC" | "STRICT_DNS" | "LOGICAL_DNS" | "EDS" | "ORIGINAL_DST"

Cluster_DiscoveryType_STATIC:       "STATIC"
Cluster_DiscoveryType_STRICT_DNS:   "STRICT_DNS"
Cluster_DiscoveryType_LOGICAL_DNS:  "LOGICAL_DNS"
Cluster_DiscoveryType_EDS:          "EDS"
Cluster_DiscoveryType_ORIGINAL_DST: "ORIGINAL_DST"

// Refer to :ref:`load balancer type <arch_overview_load_balancing_types>` architecture
// overview section for information on each type.
#Cluster_LbPolicy: "ROUND_ROBIN" | "LEAST_REQUEST" | "RING_HASH" | "RANDOM" | "ORIGINAL_DST_LB" | "MAGLEV" | "CLUSTER_PROVIDED" | "LOAD_BALANCING_POLICY_CONFIG"

Cluster_LbPolicy_ROUND_ROBIN:                  "ROUND_ROBIN"
Cluster_LbPolicy_LEAST_REQUEST:                "LEAST_REQUEST"
Cluster_LbPolicy_RING_HASH:                    "RING_HASH"
Cluster_LbPolicy_RANDOM:                       "RANDOM"
Cluster_LbPolicy_ORIGINAL_DST_LB:              "ORIGINAL_DST_LB"
Cluster_LbPolicy_MAGLEV:                       "MAGLEV"
Cluster_LbPolicy_CLUSTER_PROVIDED:             "CLUSTER_PROVIDED"
Cluster_LbPolicy_LOAD_BALANCING_POLICY_CONFIG: "LOAD_BALANCING_POLICY_CONFIG"

// When V4_ONLY is selected, the DNS resolver will only perform a lookup for
// addresses in the IPv4 family. If V6_ONLY is selected, the DNS resolver will
// only perform a lookup for addresses in the IPv6 family. If AUTO is
// specified, the DNS resolver will first perform a lookup for addresses in
// the IPv6 family and fallback to a lookup for addresses in the IPv4 family.
// For cluster types other than
// :ref:`STRICT_DNS<envoy_api_enum_value_Cluster.DiscoveryType.STRICT_DNS>` and
// :ref:`LOGICAL_DNS<envoy_api_enum_value_Cluster.DiscoveryType.LOGICAL_DNS>`,
// this setting is
// ignored.
#Cluster_DnsLookupFamily: "AUTO" | "V4_ONLY" | "V6_ONLY"

Cluster_DnsLookupFamily_AUTO:    "AUTO"
Cluster_DnsLookupFamily_V4_ONLY: "V4_ONLY"
Cluster_DnsLookupFamily_V6_ONLY: "V6_ONLY"

#Cluster_ClusterProtocolSelection: "USE_CONFIGURED_PROTOCOL" | "USE_DOWNSTREAM_PROTOCOL"

Cluster_ClusterProtocolSelection_USE_CONFIGURED_PROTOCOL: "USE_CONFIGURED_PROTOCOL"
Cluster_ClusterProtocolSelection_USE_DOWNSTREAM_PROTOCOL: "USE_DOWNSTREAM_PROTOCOL"

// If NO_FALLBACK is selected, a result
// equivalent to no healthy hosts is reported. If ANY_ENDPOINT is selected,
// any cluster endpoint may be returned (subject to policy, health checks,
// etc). If DEFAULT_SUBSET is selected, load balancing is performed over the
// endpoints matching the values from the default_subset field.
#Cluster_LbSubsetConfig_LbSubsetFallbackPolicy: "NO_FALLBACK" | "ANY_ENDPOINT" | "DEFAULT_SUBSET"

Cluster_LbSubsetConfig_LbSubsetFallbackPolicy_NO_FALLBACK:    "NO_FALLBACK"
Cluster_LbSubsetConfig_LbSubsetFallbackPolicy_ANY_ENDPOINT:   "ANY_ENDPOINT"
Cluster_LbSubsetConfig_LbSubsetFallbackPolicy_DEFAULT_SUBSET: "DEFAULT_SUBSET"

// Allows to override top level fallback policy per selector.
#Cluster_LbSubsetConfig_LbSubsetSelector_LbSubsetSelectorFallbackPolicy: "NOT_DEFINED" | "NO_FALLBACK" | "ANY_ENDPOINT" | "DEFAULT_SUBSET" | "KEYS_SUBSET"

Cluster_LbSubsetConfig_LbSubsetSelector_LbSubsetSelectorFallbackPolicy_NOT_DEFINED:    "NOT_DEFINED"
Cluster_LbSubsetConfig_LbSubsetSelector_LbSubsetSelectorFallbackPolicy_NO_FALLBACK:    "NO_FALLBACK"
Cluster_LbSubsetConfig_LbSubsetSelector_LbSubsetSelectorFallbackPolicy_ANY_ENDPOINT:   "ANY_ENDPOINT"
Cluster_LbSubsetConfig_LbSubsetSelector_LbSubsetSelectorFallbackPolicy_DEFAULT_SUBSET: "DEFAULT_SUBSET"
Cluster_LbSubsetConfig_LbSubsetSelector_LbSubsetSelectorFallbackPolicy_KEYS_SUBSET:    "KEYS_SUBSET"

// The hash function used to hash hosts onto the ketama ring.
#Cluster_RingHashLbConfig_HashFunction: "XX_HASH" | "MURMUR_HASH_2"

Cluster_RingHashLbConfig_HashFunction_XX_HASH:       "XX_HASH"
Cluster_RingHashLbConfig_HashFunction_MURMUR_HASH_2: "MURMUR_HASH_2"

// Configuration for a single upstream cluster.
// [#next-free-field: 48]
#Cluster: {
	"@type": "type.googleapis.com/envoy.api.v2.Cluster"
	// Configuration to use different transport sockets for different endpoints.
	// The entry of *envoy.transport_socket_match* in the
	// :ref:`LbEndpoint.Metadata <envoy_api_field_endpoint.LbEndpoint.metadata>`
	// is used to match against the transport sockets as they appear in the list. The first
	// :ref:`match <envoy_api_msg_Cluster.TransportSocketMatch>` is used.
	// For example, with the following match
	//
	// .. code-block:: yaml
	//
	//  transport_socket_matches:
	//  - name: "enableMTLS"
	//    match:
	//      acceptMTLS: true
	//    transport_socket:
	//      name: envoy.transport_sockets.tls
	//      config: { ... } # tls socket configuration
	//  - name: "defaultToPlaintext"
	//    match: {}
	//    transport_socket:
	//      name: envoy.transport_sockets.raw_buffer
	//
	// Connections to the endpoints whose metadata value under *envoy.transport_socket_match*
	// having "acceptMTLS"/"true" key/value pair use the "enableMTLS" socket configuration.
	//
	// If a :ref:`socket match <envoy_api_msg_Cluster.TransportSocketMatch>` with empty match
	// criteria is provided, that always match any endpoint. For example, the "defaultToPlaintext"
	// socket match in case above.
	//
	// If an endpoint metadata's value under *envoy.transport_socket_match* does not match any
	// *TransportSocketMatch*, socket configuration fallbacks to use the *tls_context* or
	// *transport_socket* specified in this cluster.
	//
	// This field allows gradual and flexible transport socket configuration changes.
	//
	// The metadata of endpoints in EDS can indicate transport socket capabilities. For example,
	// an endpoint's metadata can have two key value pairs as "acceptMTLS": "true",
	// "acceptPlaintext": "true". While some other endpoints, only accepting plaintext traffic
	// has "acceptPlaintext": "true" metadata information.
	//
	// Then the xDS server can configure the CDS to a client, Envoy A, to send mutual TLS
	// traffic for endpoints with "acceptMTLS": "true", by adding a corresponding
	// *TransportSocketMatch* in this field. Other client Envoys receive CDS without
	// *transport_socket_match* set, and still send plain text traffic to the same cluster.
	//
	// [#comment:TODO(incfly): add a detailed architecture doc on intended usage.]
	transport_socket_matches?: [...#Cluster_TransportSocketMatch]
	// Supplies the name of the cluster which must be unique across all clusters.
	// The cluster name is used when emitting
	// :ref:`statistics <config_cluster_manager_cluster_stats>` if :ref:`alt_stat_name
	// <envoy_api_field_Cluster.alt_stat_name>` is not provided.
	// Any ``:`` in the cluster name will be converted to ``_`` when emitting statistics.
	name?: string
	// An optional alternative to the cluster name to be used while emitting stats.
	// Any ``:`` in the name will be converted to ``_`` when emitting statistics. This should not be
	// confused with :ref:`Router Filter Header
	// <config_http_filters_router_x-envoy-upstream-alt-stat-name>`.
	alt_stat_name?: string
	// The :ref:`service discovery type <arch_overview_service_discovery_types>`
	// to use for resolving the cluster.
	type?: #Cluster_DiscoveryType
	// The custom cluster type.
	cluster_type?: #Cluster_CustomClusterType
	// Configuration to use for EDS updates for the Cluster.
	eds_cluster_config?: #Cluster_EdsClusterConfig
	// The timeout for new network connections to hosts in the cluster.
	connect_timeout?: string
	// Soft limit on size of the cluster’s connections read and write buffers. If
	// unspecified, an implementation defined default is applied (1MiB).
	per_connection_buffer_limit_bytes?: uint32
	// The :ref:`load balancer type <arch_overview_load_balancing_types>` to use
	// when picking a host in the cluster.
	lb_policy?: #Cluster_LbPolicy
	// If the service discovery type is
	// :ref:`STATIC<envoy_api_enum_value_Cluster.DiscoveryType.STATIC>`,
	// :ref:`STRICT_DNS<envoy_api_enum_value_Cluster.DiscoveryType.STRICT_DNS>`
	// or :ref:`LOGICAL_DNS<envoy_api_enum_value_Cluster.DiscoveryType.LOGICAL_DNS>`,
	// then hosts is required.
	//
	// .. attention::
	//
	//   **This field is deprecated**. Set the
	//   :ref:`load_assignment<envoy_api_field_Cluster.load_assignment>` field instead.
	//
	//
	// Deprecated: Do not use.
	hosts?: [...core.#Address]
	// Setting this is required for specifying members of
	// :ref:`STATIC<envoy_api_enum_value_Cluster.DiscoveryType.STATIC>`,
	// :ref:`STRICT_DNS<envoy_api_enum_value_Cluster.DiscoveryType.STRICT_DNS>`
	// or :ref:`LOGICAL_DNS<envoy_api_enum_value_Cluster.DiscoveryType.LOGICAL_DNS>` clusters.
	// This field supersedes the *hosts* field in the v2 API.
	//
	// .. attention::
	//
	//   Setting this allows non-EDS cluster types to contain embedded EDS equivalent
	//   :ref:`endpoint assignments<envoy_api_msg_ClusterLoadAssignment>`.
	//
	load_assignment?: #ClusterLoadAssignment
	// Optional :ref:`active health checking <arch_overview_health_checking>`
	// configuration for the cluster. If no
	// configuration is specified no health checking will be done and all cluster
	// members will be considered healthy at all times.
	health_checks?: [...core.#HealthCheck]
	// Optional maximum requests for a single upstream connection. This parameter
	// is respected by both the HTTP/1.1 and HTTP/2 connection pool
	// implementations. If not specified, there is no limit. Setting this
	// parameter to 1 will effectively disable keep alive.
	max_requests_per_connection?: uint32
	// Optional :ref:`circuit breaking <arch_overview_circuit_break>` for the cluster.
	circuit_breakers?: cluster.#CircuitBreakers
	// The TLS configuration for connections to the upstream cluster.
	//
	// .. attention::
	//
	//   **This field is deprecated**. Use `transport_socket` with name `tls` instead. If both are
	//   set, `transport_socket` takes priority.
	//
	// Deprecated: Do not use.
	tls_context?: auth.#UpstreamTlsContext
	// HTTP protocol options that are applied only to upstream HTTP connections.
	// These options apply to all HTTP versions.
	upstream_http_protocol_options?: core.#UpstreamHttpProtocolOptions
	// Additional options when handling HTTP requests upstream. These options will be applicable to
	// both HTTP1 and HTTP2 requests.
	common_http_protocol_options?: core.#HttpProtocolOptions
	// Additional options when handling HTTP1 requests.
	http_protocol_options?: core.#Http1ProtocolOptions
	// Even if default HTTP2 protocol options are desired, this field must be
	// set so that Envoy will assume that the upstream supports HTTP/2 when
	// making new HTTP connection pool connections. Currently, Envoy only
	// supports prior knowledge for upstream connections. Even if TLS is used
	// with ALPN, `http2_protocol_options` must be specified. As an aside this allows HTTP/2
	// connections to happen over plain text.
	http2_protocol_options?: core.#Http2ProtocolOptions
	// The extension_protocol_options field is used to provide extension-specific protocol options
	// for upstream connections. The key should match the extension filter name, such as
	// "envoy.filters.network.thrift_proxy". See the extension's documentation for details on
	// specific options.
	//
	// Deprecated: Do not use.
	extension_protocol_options?: [string]: _struct.#Struct
	// The extension_protocol_options field is used to provide extension-specific protocol options
	// for upstream connections. The key should match the extension filter name, such as
	// "envoy.filters.network.thrift_proxy". See the extension's documentation for details on
	// specific options.
	typed_extension_protocol_options?: [string]: _
	// If the DNS refresh rate is specified and the cluster type is either
	// :ref:`STRICT_DNS<envoy_api_enum_value_Cluster.DiscoveryType.STRICT_DNS>`,
	// or :ref:`LOGICAL_DNS<envoy_api_enum_value_Cluster.DiscoveryType.LOGICAL_DNS>`,
	// this value is used as the cluster’s DNS refresh
	// rate. The value configured must be at least 1ms. If this setting is not specified, the
	// value defaults to 5000ms. For cluster types other than
	// :ref:`STRICT_DNS<envoy_api_enum_value_Cluster.DiscoveryType.STRICT_DNS>`
	// and :ref:`LOGICAL_DNS<envoy_api_enum_value_Cluster.DiscoveryType.LOGICAL_DNS>`
	// this setting is ignored.
	dns_refresh_rate?: string
	// If the DNS failure refresh rate is specified and the cluster type is either
	// :ref:`STRICT_DNS<envoy_api_enum_value_Cluster.DiscoveryType.STRICT_DNS>`,
	// or :ref:`LOGICAL_DNS<envoy_api_enum_value_Cluster.DiscoveryType.LOGICAL_DNS>`,
	// this is used as the cluster’s DNS refresh rate when requests are failing. If this setting is
	// not specified, the failure refresh rate defaults to the DNS refresh rate. For cluster types
	// other than :ref:`STRICT_DNS<envoy_api_enum_value_Cluster.DiscoveryType.STRICT_DNS>` and
	// :ref:`LOGICAL_DNS<envoy_api_enum_value_Cluster.DiscoveryType.LOGICAL_DNS>` this setting is
	// ignored.
	dns_failure_refresh_rate?: #Cluster_RefreshRate
	// Optional configuration for setting cluster's DNS refresh rate. If the value is set to true,
	// cluster's DNS refresh rate will be set to resource record's TTL which comes from DNS
	// resolution.
	respect_dns_ttl?: bool
	// The DNS IP address resolution policy. If this setting is not specified, the
	// value defaults to
	// :ref:`AUTO<envoy_api_enum_value_Cluster.DnsLookupFamily.AUTO>`.
	dns_lookup_family?: #Cluster_DnsLookupFamily
	// If DNS resolvers are specified and the cluster type is either
	// :ref:`STRICT_DNS<envoy_api_enum_value_Cluster.DiscoveryType.STRICT_DNS>`,
	// or :ref:`LOGICAL_DNS<envoy_api_enum_value_Cluster.DiscoveryType.LOGICAL_DNS>`,
	// this value is used to specify the cluster’s dns resolvers.
	// If this setting is not specified, the value defaults to the default
	// resolver, which uses /etc/resolv.conf for configuration. For cluster types
	// other than
	// :ref:`STRICT_DNS<envoy_api_enum_value_Cluster.DiscoveryType.STRICT_DNS>`
	// and :ref:`LOGICAL_DNS<envoy_api_enum_value_Cluster.DiscoveryType.LOGICAL_DNS>`
	// this setting is ignored.
	// Setting this value causes failure if the
	// ``envoy.restart_features.use_apple_api_for_dns_lookups`` runtime value is true during
	// server startup. Apple's API only allows overriding DNS resolvers via system settings.
	dns_resolvers?: [...core.#Address]
	// [#next-major-version: Reconcile DNS options in a single message.]
	// Always use TCP queries instead of UDP queries for DNS lookups.
	// Setting this value causes failure if the
	// ``envoy.restart_features.use_apple_api_for_dns_lookups`` runtime value is true during
	// server startup. Apple' API only uses UDP for DNS resolution.
	use_tcp_for_dns_lookups?: bool
	// If specified, outlier detection will be enabled for this upstream cluster.
	// Each of the configuration values can be overridden via
	// :ref:`runtime values <config_cluster_manager_cluster_runtime_outlier_detection>`.
	outlier_detection?: cluster.#OutlierDetection
	// The interval for removing stale hosts from a cluster type
	// :ref:`ORIGINAL_DST<envoy_api_enum_value_Cluster.DiscoveryType.ORIGINAL_DST>`.
	// Hosts are considered stale if they have not been used
	// as upstream destinations during this interval. New hosts are added
	// to original destination clusters on demand as new connections are
	// redirected to Envoy, causing the number of hosts in the cluster to
	// grow over time. Hosts that are not stale (they are actively used as
	// destinations) are kept in the cluster, which allows connections to
	// them remain open, saving the latency that would otherwise be spent
	// on opening new connections. If this setting is not specified, the
	// value defaults to 5000ms. For cluster types other than
	// :ref:`ORIGINAL_DST<envoy_api_enum_value_Cluster.DiscoveryType.ORIGINAL_DST>`
	// this setting is ignored.
	cleanup_interval?: string
	// Optional configuration used to bind newly established upstream connections.
	// This overrides any bind_config specified in the bootstrap proto.
	// If the address and port are empty, no bind will be performed.
	upstream_bind_config?: core.#BindConfig
	// Configuration for load balancing subsetting.
	lb_subset_config?: #Cluster_LbSubsetConfig
	// Optional configuration for the Ring Hash load balancing policy.
	ring_hash_lb_config?: #Cluster_RingHashLbConfig
	// Optional configuration for the Original Destination load balancing policy.
	original_dst_lb_config?: #Cluster_OriginalDstLbConfig
	// Optional configuration for the LeastRequest load balancing policy.
	least_request_lb_config?: #Cluster_LeastRequestLbConfig
	// Common configuration for all load balancer implementations.
	common_lb_config?: #Cluster_CommonLbConfig
	// Optional custom transport socket implementation to use for upstream connections.
	// To setup TLS, set a transport socket with name `tls` and
	// :ref:`UpstreamTlsContexts <envoy_api_msg_auth.UpstreamTlsContext>` in the `typed_config`.
	// If no transport socket configuration is specified, new connections
	// will be set up with plaintext.
	transport_socket?: core.#TransportSocket
	// The Metadata field can be used to provide additional information about the
	// cluster. It can be used for stats, logging, and varying filter behavior.
	// Fields should use reverse DNS notation to denote which entity within Envoy
	// will need the information. For instance, if the metadata is intended for
	// the Router filter, the filter name should be specified as *envoy.filters.http.router*.
	metadata?: core.#Metadata
	// Determines how Envoy selects the protocol used to speak to upstream hosts.
	protocol_selection?: #Cluster_ClusterProtocolSelection
	// Optional options for upstream connections.
	upstream_connection_options?: #UpstreamConnectionOptions
	// If an upstream host becomes unhealthy (as determined by the configured health checks
	// or outlier detection), immediately close all connections to the failed host.
	//
	// .. note::
	//
	//   This is currently only supported for connections created by tcp_proxy.
	//
	// .. note::
	//
	//   The current implementation of this feature closes all connections immediately when
	//   the unhealthy status is detected. If there are a large number of connections open
	//   to an upstream host that becomes unhealthy, Envoy may spend a substantial amount of
	//   time exclusively closing these connections, and not processing any other traffic.
	close_connections_on_host_health_failure?: bool
	// If set to true, Envoy will ignore the health value of a host when processing its removal
	// from service discovery. This means that if active health checking is used, Envoy will *not*
	// wait for the endpoint to go unhealthy before removing it.
	drain_connections_on_host_removal?: bool
	// An (optional) network filter chain, listed in the order the filters should be applied.
	// The chain will be applied to all outgoing connections that Envoy makes to the upstream
	// servers of this cluster.
	filters?: [...cluster.#Filter]
	// [#not-implemented-hide:] New mechanism for LB policy configuration. Used only if the
	// :ref:`lb_policy<envoy_api_field_Cluster.lb_policy>` field has the value
	// :ref:`LOAD_BALANCING_POLICY_CONFIG<envoy_api_enum_value_Cluster.LbPolicy.LOAD_BALANCING_POLICY_CONFIG>`.
	load_balancing_policy?: #LoadBalancingPolicy
	// [#not-implemented-hide:]
	// If present, tells the client where to send load reports via LRS. If not present, the
	// client will fall back to a client-side default, which may be either (a) don't send any
	// load reports or (b) send load reports for all clusters to a single default server
	// (which may be configured in the bootstrap file).
	//
	// Note that if multiple clusters point to the same LRS server, the client may choose to
	// create a separate stream for each cluster or it may choose to coalesce the data for
	// multiple clusters onto a single stream. Either way, the client must make sure to send
	// the data for any given cluster on no more than one stream.
	//
	// [#next-major-version: In the v3 API, we should consider restructuring this somehow,
	// maybe by allowing LRS to go on the ADS stream, or maybe by moving some of the negotiation
	// from the LRS stream here.]
	lrs_server?: core.#ConfigSource
	// If track_timeout_budgets is true, the :ref:`timeout budget histograms
	// <config_cluster_manager_cluster_stats_timeout_budgets>` will be published for each
	// request. These show what percentage of a request's per try and global timeout was used. A value
	// of 0 would indicate that none of the timeout was used or that the timeout was infinite. A value
	// of 100 would indicate that the request took the entirety of the timeout given to it.
	track_timeout_budgets?: bool
}

// [#not-implemented-hide:] Extensible load balancing policy configuration.
//
// Every LB policy defined via this mechanism will be identified via a unique name using reverse
// DNS notation. If the policy needs configuration parameters, it must define a message for its
// own configuration, which will be stored in the config field. The name of the policy will tell
// clients which type of message they should expect to see in the config field.
//
// Note that there are cases where it is useful to be able to independently select LB policies
// for choosing a locality and for choosing an endpoint within that locality. For example, a
// given deployment may always use the same policy to choose the locality, but for choosing the
// endpoint within the locality, some clusters may use weighted-round-robin, while others may
// use some sort of session-based balancing.
//
// This can be accomplished via hierarchical LB policies, where the parent LB policy creates a
// child LB policy for each locality. For each request, the parent chooses the locality and then
// delegates to the child policy for that locality to choose the endpoint within the locality.
//
// To facilitate this, the config message for the top-level LB policy may include a field of
// type LoadBalancingPolicy that specifies the child policy.
#LoadBalancingPolicy: {
	"@type": "type.googleapis.com/envoy.api.v2.LoadBalancingPolicy"
	// Each client will iterate over the list in order and stop at the first policy that it
	// supports. This provides a mechanism for starting to use new LB policies that are not yet
	// supported by all clients.
	policies?: [...#LoadBalancingPolicy_Policy]
}

// An extensible structure containing the address Envoy should bind to when
// establishing upstream connections.
#UpstreamBindConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.UpstreamBindConfig"
	// The address Envoy should bind to when establishing upstream connections.
	source_address?: core.#Address
}

#UpstreamConnectionOptions: {
	"@type": "type.googleapis.com/envoy.api.v2.UpstreamConnectionOptions"
	// If set then set SO_KEEPALIVE on the socket to enable TCP Keepalives.
	tcp_keepalive?: core.#TcpKeepalive
}

// TransportSocketMatch specifies what transport socket config will be used
// when the match conditions are satisfied.
#Cluster_TransportSocketMatch: {
	"@type": "type.googleapis.com/envoy.api.v2.Cluster_TransportSocketMatch"
	// The name of the match, used in stats generation.
	name?: string
	// Optional endpoint metadata match criteria.
	// The connection to the endpoint with metadata matching what is set in this field
	// will use the transport socket configuration specified here.
	// The endpoint's metadata entry in *envoy.transport_socket_match* is used to match
	// against the values specified in this field.
	match?: _struct.#Struct
	// The configuration of the transport socket.
	transport_socket?: core.#TransportSocket
}

// Extended cluster type.
#Cluster_CustomClusterType: {
	"@type": "type.googleapis.com/envoy.api.v2.Cluster_CustomClusterType"
	// The type of the cluster to instantiate. The name must match a supported cluster type.
	name?: string
	// Cluster specific configuration which depends on the cluster being instantiated.
	// See the supported cluster for further documentation.
	typed_config?: _
}

// Only valid when discovery type is EDS.
#Cluster_EdsClusterConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.Cluster_EdsClusterConfig"
	// Configuration for the source of EDS updates for this Cluster.
	eds_config?: core.#ConfigSource
	// Optional alternative to cluster name to present to EDS. This does not
	// have the same restrictions as cluster name, i.e. it may be arbitrary
	// length.
	service_name?: string
}

// Optionally divide the endpoints in this cluster into subsets defined by
// endpoint metadata and selected by route and weighted cluster metadata.
// [#next-free-field: 8]
#Cluster_LbSubsetConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.Cluster_LbSubsetConfig"
	// The behavior used when no endpoint subset matches the selected route's
	// metadata. The value defaults to
	// :ref:`NO_FALLBACK<envoy_api_enum_value_Cluster.LbSubsetConfig.LbSubsetFallbackPolicy.NO_FALLBACK>`.
	fallback_policy?: #Cluster_LbSubsetConfig_LbSubsetFallbackPolicy
	// Specifies the default subset of endpoints used during fallback if
	// fallback_policy is
	// :ref:`DEFAULT_SUBSET<envoy_api_enum_value_Cluster.LbSubsetConfig.LbSubsetFallbackPolicy.DEFAULT_SUBSET>`.
	// Each field in default_subset is
	// compared to the matching LbEndpoint.Metadata under the *envoy.lb*
	// namespace. It is valid for no hosts to match, in which case the behavior
	// is the same as a fallback_policy of
	// :ref:`NO_FALLBACK<envoy_api_enum_value_Cluster.LbSubsetConfig.LbSubsetFallbackPolicy.NO_FALLBACK>`.
	default_subset?: _struct.#Struct
	// For each entry, LbEndpoint.Metadata's
	// *envoy.lb* namespace is traversed and a subset is created for each unique
	// combination of key and value. For example:
	//
	// .. code-block:: json
	//
	//   { "subset_selectors": [
	//       { "keys": [ "version" ] },
	//       { "keys": [ "stage", "hardware_type" ] }
	//   ]}
	//
	// A subset is matched when the metadata from the selected route and
	// weighted cluster contains the same keys and values as the subset's
	// metadata. The same host may appear in multiple subsets.
	subset_selectors?: [...#Cluster_LbSubsetConfig_LbSubsetSelector]
	// If true, routing to subsets will take into account the localities and locality weights of the
	// endpoints when making the routing decision.
	//
	// There are some potential pitfalls associated with enabling this feature, as the resulting
	// traffic split after applying both a subset match and locality weights might be undesirable.
	//
	// Consider for example a situation in which you have 50/50 split across two localities X/Y
	// which have 100 hosts each without subsetting. If the subset LB results in X having only 1
	// host selected but Y having 100, then a lot more load is being dumped on the single host in X
	// than originally anticipated in the load balancing assignment delivered via EDS.
	locality_weight_aware?: bool
	// When used with locality_weight_aware, scales the weight of each locality by the ratio
	// of hosts in the subset vs hosts in the original subset. This aims to even out the load
	// going to an individual locality if said locality is disproportionately affected by the
	// subset predicate.
	scale_locality_weight?: bool
	// If true, when a fallback policy is configured and its corresponding subset fails to find
	// a host this will cause any host to be selected instead.
	//
	// This is useful when using the default subset as the fallback policy, given the default
	// subset might become empty. With this option enabled, if that happens the LB will attempt
	// to select a host from the entire cluster.
	panic_mode_any?: bool
	// If true, metadata specified for a metadata key will be matched against the corresponding
	// endpoint metadata if the endpoint metadata matches the value exactly OR it is a list value
	// and any of the elements in the list matches the criteria.
	list_as_any?: bool
}

// Specific configuration for the LeastRequest load balancing policy.
#Cluster_LeastRequestLbConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.Cluster_LeastRequestLbConfig"
	// The number of random healthy hosts from which the host with the fewest active requests will
	// be chosen. Defaults to 2 so that we perform two-choice selection if the field is not set.
	choice_count?: uint32
}

// Specific configuration for the :ref:`RingHash<arch_overview_load_balancing_types_ring_hash>`
// load balancing policy.
#Cluster_RingHashLbConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.Cluster_RingHashLbConfig"
	// Minimum hash ring size. The larger the ring is (that is, the more hashes there are for each
	// provided host) the better the request distribution will reflect the desired weights. Defaults
	// to 1024 entries, and limited to 8M entries. See also
	// :ref:`maximum_ring_size<envoy_api_field_Cluster.RingHashLbConfig.maximum_ring_size>`.
	minimum_ring_size?: uint64
	// The hash function used to hash hosts onto the ketama ring. The value defaults to
	// :ref:`XX_HASH<envoy_api_enum_value_Cluster.RingHashLbConfig.HashFunction.XX_HASH>`.
	hash_function?: #Cluster_RingHashLbConfig_HashFunction
	// Maximum hash ring size. Defaults to 8M entries, and limited to 8M entries, but can be lowered
	// to further constrain resource use. See also
	// :ref:`minimum_ring_size<envoy_api_field_Cluster.RingHashLbConfig.minimum_ring_size>`.
	maximum_ring_size?: uint64
}

// Specific configuration for the
// :ref:`Original Destination <arch_overview_load_balancing_types_original_destination>`
// load balancing policy.
#Cluster_OriginalDstLbConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.Cluster_OriginalDstLbConfig"
	// When true, :ref:`x-envoy-original-dst-host
	// <config_http_conn_man_headers_x-envoy-original-dst-host>` can be used to override destination
	// address.
	//
	// .. attention::
	//
	//   This header isn't sanitized by default, so enabling this feature allows HTTP clients to
	//   route traffic to arbitrary hosts and/or ports, which may have serious security
	//   consequences.
	//
	// .. note::
	//
	//   If the header appears multiple times only the first value is used.
	use_http_header?: bool
}

// Common configuration for all load balancer implementations.
// [#next-free-field: 8]
#Cluster_CommonLbConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.Cluster_CommonLbConfig"
	// Configures the :ref:`healthy panic threshold <arch_overview_load_balancing_panic_threshold>`.
	// If not specified, the default is 50%.
	// To disable panic mode, set to 0%.
	//
	// .. note::
	//   The specified percent will be truncated to the nearest 1%.
	healthy_panic_threshold?:     _type.#Percent
	zone_aware_lb_config?:        #Cluster_CommonLbConfig_ZoneAwareLbConfig
	locality_weighted_lb_config?: #Cluster_CommonLbConfig_LocalityWeightedLbConfig
	// If set, all health check/weight/metadata updates that happen within this duration will be
	// merged and delivered in one shot when the duration expires. The start of the duration is when
	// the first update happens. This is useful for big clusters, with potentially noisy deploys
	// that might trigger excessive CPU usage due to a constant stream of healthcheck state changes
	// or metadata updates. The first set of updates to be seen apply immediately (e.g.: a new
	// cluster). Please always keep in mind that the use of sandbox technologies may change this
	// behavior.
	//
	// If this is not set, we default to a merge window of 1000ms. To disable it, set the merge
	// window to 0.
	//
	// Note: merging does not apply to cluster membership changes (e.g.: adds/removes); this is
	// because merging those updates isn't currently safe. See
	// https://github.com/envoyproxy/envoy/pull/3941.
	update_merge_window?: string
	// If set to true, Envoy will not consider new hosts when computing load balancing weights until
	// they have been health checked for the first time. This will have no effect unless
	// active health checking is also configured.
	//
	// Ignoring a host means that for any load balancing calculations that adjust weights based
	// on the ratio of eligible hosts and total hosts (priority spillover, locality weighting and
	// panic mode) Envoy will exclude these hosts in the denominator.
	//
	// For example, with hosts in two priorities P0 and P1, where P0 looks like
	// {healthy, unhealthy (new), unhealthy (new)}
	// and where P1 looks like
	// {healthy, healthy}
	// all traffic will still hit P0, as 1 / (3 - 2) = 1.
	//
	// Enabling this will allow scaling up the number of hosts for a given cluster without entering
	// panic mode or triggering priority spillover, assuming the hosts pass the first health check.
	//
	// If panic mode is triggered, new hosts are still eligible for traffic; they simply do not
	// contribute to the calculation when deciding whether panic mode is enabled or not.
	ignore_new_hosts_until_first_hc?: bool
	// If set to `true`, the cluster manager will drain all existing
	// connections to upstream hosts whenever hosts are added or removed from the cluster.
	close_connections_on_host_set_change?: bool
	// Common Configuration for all consistent hashing load balancers (MaglevLb, RingHashLb, etc.)
	consistent_hashing_lb_config?: #Cluster_CommonLbConfig_ConsistentHashingLbConfig
}

#Cluster_RefreshRate: {
	"@type": "type.googleapis.com/envoy.api.v2.Cluster_RefreshRate"
	// Specifies the base interval between refreshes. This parameter is required and must be greater
	// than zero and less than
	// :ref:`max_interval <envoy_api_field_Cluster.RefreshRate.max_interval>`.
	base_interval?: string
	// Specifies the maximum interval between refreshes. This parameter is optional, but must be
	// greater than or equal to the
	// :ref:`base_interval <envoy_api_field_Cluster.RefreshRate.base_interval>`  if set. The default
	// is 10 times the :ref:`base_interval <envoy_api_field_Cluster.RefreshRate.base_interval>`.
	max_interval?: string
}

// Specifications for subsets.
#Cluster_LbSubsetConfig_LbSubsetSelector: {
	"@type": "type.googleapis.com/envoy.api.v2.Cluster_LbSubsetConfig_LbSubsetSelector"
	// List of keys to match with the weighted cluster metadata.
	keys?: [...string]
	// The behavior used when no endpoint subset matches the selected route's
	// metadata.
	fallback_policy?: #Cluster_LbSubsetConfig_LbSubsetSelector_LbSubsetSelectorFallbackPolicy
	// Subset of
	// :ref:`keys<envoy_api_field_Cluster.LbSubsetConfig.LbSubsetSelector.keys>` used by
	// :ref:`KEYS_SUBSET<envoy_api_enum_value_Cluster.LbSubsetConfig.LbSubsetSelector.LbSubsetSelectorFallbackPolicy.KEYS_SUBSET>`
	// fallback policy.
	// It has to be a non empty list if KEYS_SUBSET fallback policy is selected.
	// For any other fallback policy the parameter is not used and should not be set.
	// Only values also present in
	// :ref:`keys<envoy_api_field_Cluster.LbSubsetConfig.LbSubsetSelector.keys>` are allowed, but
	// `fallback_keys_subset` cannot be equal to `keys`.
	fallback_keys_subset?: [...string]
}

// Configuration for :ref:`zone aware routing
// <arch_overview_load_balancing_zone_aware_routing>`.
#Cluster_CommonLbConfig_ZoneAwareLbConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.Cluster_CommonLbConfig_ZoneAwareLbConfig"
	// Configures percentage of requests that will be considered for zone aware routing
	// if zone aware routing is configured. If not specified, the default is 100%.
	// * :ref:`runtime values <config_cluster_manager_cluster_runtime_zone_routing>`.
	// * :ref:`Zone aware routing support <arch_overview_load_balancing_zone_aware_routing>`.
	routing_enabled?: _type.#Percent
	// Configures minimum upstream cluster size required for zone aware routing
	// If upstream cluster size is less than specified, zone aware routing is not performed
	// even if zone aware routing is configured. If not specified, the default is 6.
	// * :ref:`runtime values <config_cluster_manager_cluster_runtime_zone_routing>`.
	// * :ref:`Zone aware routing support <arch_overview_load_balancing_zone_aware_routing>`.
	min_cluster_size?: uint64
	// If set to true, Envoy will not consider any hosts when the cluster is in :ref:`panic
	// mode<arch_overview_load_balancing_panic_threshold>`. Instead, the cluster will fail all
	// requests as if all hosts are unhealthy. This can help avoid potentially overwhelming a
	// failing service.
	fail_traffic_on_panic?: bool
}

// Configuration for :ref:`locality weighted load balancing
// <arch_overview_load_balancing_locality_weighted_lb>`
#Cluster_CommonLbConfig_LocalityWeightedLbConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.Cluster_CommonLbConfig_LocalityWeightedLbConfig"
}

// Common Configuration for all consistent hashing load balancers (MaglevLb, RingHashLb, etc.)
#Cluster_CommonLbConfig_ConsistentHashingLbConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.Cluster_CommonLbConfig_ConsistentHashingLbConfig"
	// If set to `true`, the cluster will use hostname instead of the resolved
	// address as the key to consistently hash to an upstream host. Only valid for StrictDNS clusters with hostnames which resolve to a single IP address.
	use_hostname_for_hashing?: bool
}

#LoadBalancingPolicy_Policy: {
	"@type": "type.googleapis.com/envoy.api.v2.LoadBalancingPolicy_Policy"
	// Required. The name of the LB policy.
	name?: string
	// Optional config for the LB policy.
	// No more than one of these two fields may be populated.
	//
	// Deprecated: Do not use.
	config?:       _struct.#Struct
	typed_config?: _
}
