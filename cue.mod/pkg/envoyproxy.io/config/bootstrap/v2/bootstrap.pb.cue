package v2

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
	auth "envoyproxy.io/api/v2/auth"
	core "envoyproxy.io/api/v2/core"
	v2 "envoyproxy.io/config/metrics/v2"
	v21 "envoyproxy.io/config/trace/v2"
	v22 "envoyproxy.io/api/v2"
	v2alpha "envoyproxy.io/config/overload/v2alpha"
)

// Bootstrap :ref:`configuration overview <config_overview_bootstrap>`.
// [#next-free-field: 21]
#Bootstrap: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v2.Bootstrap"
	// Node identity to present to the management server and for instance
	// identification purposes (e.g. in generated headers).
	node?: core.#Node
	// Statically specified resources.
	static_resources?: #Bootstrap_StaticResources
	// xDS configuration sources.
	dynamic_resources?: #Bootstrap_DynamicResources
	// Configuration for the cluster manager which owns all upstream clusters
	// within the server.
	cluster_manager?: #ClusterManager
	// Health discovery service config option.
	// (:ref:`core.ApiConfigSource <envoy_api_msg_core.ApiConfigSource>`)
	hds_config?: core.#ApiConfigSource
	// Optional file system path to search for startup flag files.
	flags_path?: string
	// Optional set of stats sinks.
	stats_sinks?: [...v2.#StatsSink]
	// Configuration for internal processing of stats.
	stats_config?: v2.#StatsConfig
	// Optional duration between flushes to configured stats sinks. For
	// performance reasons Envoy latches counters and only flushes counters and
	// gauges at a periodic interval. If not specified the default is 5000ms (5
	// seconds).
	// Duration must be at least 1ms and at most 5 min.
	stats_flush_interval?: string
	// Optional watchdog configuration.
	watchdog?: #Watchdog
	// Configuration for an external tracing provider.
	//
	// .. attention::
	//  This field has been deprecated in favor of :ref:`HttpConnectionManager.Tracing.provider
	//  <envoy_api_field_config.filter.network.http_connection_manager.v2.HttpConnectionManager.Tracing.provider>`.
	tracing?: v21.#Tracing
	// Configuration for the runtime configuration provider (deprecated). If not
	// specified, a “null” provider will be used which will result in all defaults
	// being used.
	//
	// Deprecated: Do not use.
	runtime?: #Runtime
	// Configuration for the runtime configuration provider. If not
	// specified, a “null” provider will be used which will result in all defaults
	// being used.
	layered_runtime?: #LayeredRuntime
	// Configuration for the local administration HTTP server.
	admin?: #Admin
	// Optional overload manager configuration.
	overload_manager?: v2alpha.#OverloadManager
	// Enable :ref:`stats for event dispatcher <operations_performance>`, defaults to false.
	// Note that this records a value for each iteration of the event loop on every thread. This
	// should normally be minimal overhead, but when using
	// :ref:`statsd <envoy_api_msg_config.metrics.v2.StatsdSink>`, it will send each observed value
	// over the wire individually because the statsd protocol doesn't have any way to represent a
	// histogram summary. Be aware that this can be a very large volume of data.
	enable_dispatcher_stats?: bool
	// Optional string which will be used in lieu of x-envoy in prefixing headers.
	//
	// For example, if this string is present and set to X-Foo, then x-envoy-retry-on will be
	// transformed into x-foo-retry-on etc.
	//
	// Note this applies to the headers Envoy will generate, the headers Envoy will sanitize, and the
	// headers Envoy will trust for core code and core extensions only. Be VERY careful making
	// changes to this string, especially in multi-layer Envoy deployments or deployments using
	// extensions which are not upstream.
	header_prefix?: string
	// Optional proxy version which will be used to set the value of :ref:`server.version statistic
	// <server_statistics>` if specified. Envoy will not process this value, it will be sent as is to
	// :ref:`stats sinks <envoy_api_msg_config.metrics.v2.StatsSink>`.
	stats_server_version_override?: uint64
	// Always use TCP queries instead of UDP queries for DNS lookups.
	// This may be overridden on a per-cluster basis in cds_config,
	// when :ref:`dns_resolvers <envoy_api_field_Cluster.dns_resolvers>` and
	// :ref:`use_tcp_for_dns_lookups <envoy_api_field_Cluster.use_tcp_for_dns_lookups>` are
	// specified.
	// Setting this value causes failure if the
	// ``envoy.restart_features.use_apple_api_for_dns_lookups`` runtime value is true during
	// server startup. Apple' API only uses UDP for DNS resolution.
	use_tcp_for_dns_lookups?: bool
}

// Administration interface :ref:`operations documentation
// <operations_admin_interface>`.
#Admin: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v2.Admin"
	// The path to write the access log for the administration server. If no
	// access log is desired specify ‘/dev/null’. This is only required if
	// :ref:`address <envoy_api_field_config.bootstrap.v2.Admin.address>` is set.
	access_log_path?: string
	// The cpu profiler output path for the administration server. If no profile
	// path is specified, the default is ‘/var/log/envoy/envoy.prof’.
	profile_path?: string
	// The TCP address that the administration server will listen on.
	// If not specified, Envoy will not start an administration server.
	address?: core.#Address
	// Additional socket options that may not be present in Envoy source code or
	// precompiled binaries.
	socket_options?: [...core.#SocketOption]
}

// Cluster manager :ref:`architecture overview <arch_overview_cluster_manager>`.
#ClusterManager: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v2.ClusterManager"
	// Name of the local cluster (i.e., the cluster that owns the Envoy running
	// this configuration). In order to enable :ref:`zone aware routing
	// <arch_overview_load_balancing_zone_aware_routing>` this option must be set.
	// If *local_cluster_name* is defined then :ref:`clusters
	// <envoy_api_msg_Cluster>` must be defined in the :ref:`Bootstrap
	// static cluster resources
	// <envoy_api_field_config.bootstrap.v2.Bootstrap.StaticResources.clusters>`. This is unrelated to
	// the :option:`--service-cluster` option which does not `affect zone aware
	// routing <https://github.com/envoyproxy/envoy/issues/774>`_.
	local_cluster_name?: string
	// Optional global configuration for outlier detection.
	outlier_detection?: #ClusterManager_OutlierDetection
	// Optional configuration used to bind newly established upstream connections.
	// This may be overridden on a per-cluster basis by upstream_bind_config in the cds_config.
	upstream_bind_config?: core.#BindConfig
	// A management server endpoint to stream load stats to via
	// *StreamLoadStats*. This must have :ref:`api_type
	// <envoy_api_field_core.ApiConfigSource.api_type>` :ref:`GRPC
	// <envoy_api_enum_value_core.ApiConfigSource.ApiType.GRPC>`.
	load_stats_config?: core.#ApiConfigSource
}

// Envoy process watchdog configuration. When configured, this monitors for
// nonresponsive threads and kills the process after the configured thresholds.
// See the :ref:`watchdog documentation <operations_performance_watchdog>` for more information.
#Watchdog: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v2.Watchdog"
	// The duration after which Envoy counts a nonresponsive thread in the
	// *watchdog_miss* statistic. If not specified the default is 200ms.
	miss_timeout?: string
	// The duration after which Envoy counts a nonresponsive thread in the
	// *watchdog_mega_miss* statistic. If not specified the default is
	// 1000ms.
	megamiss_timeout?: string
	// If a watched thread has been nonresponsive for this duration, assume a
	// programming error and kill the entire Envoy process. Set to 0 to disable
	// kill behavior. If not specified the default is 0 (disabled).
	kill_timeout?: string
	// If at least two watched threads have been nonresponsive for at least this
	// duration assume a true deadlock and kill the entire Envoy process. Set to 0
	// to disable this behavior. If not specified the default is 0 (disabled).
	multikill_timeout?: string
}

// Runtime :ref:`configuration overview <config_runtime>` (deprecated).
#Runtime: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v2.Runtime"
	// The implementation assumes that the file system tree is accessed via a
	// symbolic link. An atomic link swap is used when a new tree should be
	// switched to. This parameter specifies the path to the symbolic link. Envoy
	// will watch the location for changes and reload the file system tree when
	// they happen. If this parameter is not set, there will be no disk based
	// runtime.
	symlink_root?: string
	// Specifies the subdirectory to load within the root directory. This is
	// useful if multiple systems share the same delivery mechanism. Envoy
	// configuration elements can be contained in a dedicated subdirectory.
	subdirectory?: string
	// Specifies an optional subdirectory to load within the root directory. If
	// specified and the directory exists, configuration values within this
	// directory will override those found in the primary subdirectory. This is
	// useful when Envoy is deployed across many different types of servers.
	// Sometimes it is useful to have a per service cluster directory for runtime
	// configuration. See below for exactly how the override directory is used.
	override_subdirectory?: string
	// Static base runtime. This will be :ref:`overridden
	// <config_runtime_layering>` by other runtime layers, e.g.
	// disk or admin. This follows the :ref:`runtime protobuf JSON representation
	// encoding <config_runtime_proto_json>`.
	base?: _struct.#Struct
}

// [#next-free-field: 6]
#RuntimeLayer: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v2.RuntimeLayer"
	// Descriptive name for the runtime layer. This is only used for the runtime
	// :http:get:`/runtime` output.
	name?: string
	// :ref:`Static runtime <config_runtime_bootstrap>` layer.
	// This follows the :ref:`runtime protobuf JSON representation encoding
	// <config_runtime_proto_json>`. Unlike static xDS resources, this static
	// layer is overridable by later layers in the runtime virtual filesystem.
	static_layer?: _struct.#Struct
	disk_layer?:   #RuntimeLayer_DiskLayer
	admin_layer?:  #RuntimeLayer_AdminLayer
	rtds_layer?:   #RuntimeLayer_RtdsLayer
}

// Runtime :ref:`configuration overview <config_runtime>`.
#LayeredRuntime: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v2.LayeredRuntime"
	// The :ref:`layers <config_runtime_layering>` of the runtime. This is ordered
	// such that later layers in the list overlay earlier entries.
	layers?: [...#RuntimeLayer]
}

#Bootstrap_StaticResources: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v2.Bootstrap_StaticResources"
	// Static :ref:`Listeners <envoy_api_msg_Listener>`. These listeners are
	// available regardless of LDS configuration.
	listeners?: [...v22.#Listener]
	// If a network based configuration source is specified for :ref:`cds_config
	// <envoy_api_field_config.bootstrap.v2.Bootstrap.DynamicResources.cds_config>`, it's necessary
	// to have some initial cluster definitions available to allow Envoy to know
	// how to speak to the management server. These cluster definitions may not
	// use :ref:`EDS <arch_overview_dynamic_config_eds>` (i.e. they should be static
	// IP or DNS-based).
	clusters?: [...v22.#Cluster]
	// These static secrets can be used by :ref:`SdsSecretConfig
	// <envoy_api_msg_auth.SdsSecretConfig>`
	secrets?: [...auth.#Secret]
}

#Bootstrap_DynamicResources: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v2.Bootstrap_DynamicResources"
	// All :ref:`Listeners <envoy_api_msg_Listener>` are provided by a single
	// :ref:`LDS <arch_overview_dynamic_config_lds>` configuration source.
	lds_config?: core.#ConfigSource
	// All post-bootstrap :ref:`Cluster <envoy_api_msg_Cluster>` definitions are
	// provided by a single :ref:`CDS <arch_overview_dynamic_config_cds>`
	// configuration source.
	cds_config?: core.#ConfigSource
	// A single :ref:`ADS <config_overview_ads>` source may be optionally
	// specified. This must have :ref:`api_type
	// <envoy_api_field_core.ApiConfigSource.api_type>` :ref:`GRPC
	// <envoy_api_enum_value_core.ApiConfigSource.ApiType.GRPC>`. Only
	// :ref:`ConfigSources <envoy_api_msg_core.ConfigSource>` that have
	// the :ref:`ads <envoy_api_field_core.ConfigSource.ads>` field set will be
	// streamed on the ADS channel.
	ads_config?: core.#ApiConfigSource
}

#ClusterManager_OutlierDetection: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v2.ClusterManager_OutlierDetection"
	// Specifies the path to the outlier event log.
	event_log_path?: string
	// [#not-implemented-hide:]
	// The gRPC service for the outlier detection event service.
	// If empty, outlier detection events won't be sent to a remote endpoint.
	event_service?: core.#EventServiceConfig
}

// :ref:`Disk runtime <config_runtime_local_disk>` layer.
#RuntimeLayer_DiskLayer: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v2.RuntimeLayer_DiskLayer"
	// The implementation assumes that the file system tree is accessed via a
	// symbolic link. An atomic link swap is used when a new tree should be
	// switched to. This parameter specifies the path to the symbolic link.
	// Envoy will watch the location for changes and reload the file system tree
	// when they happen. See documentation on runtime :ref:`atomicity
	// <config_runtime_atomicity>` for further details on how reloads are
	// treated.
	symlink_root?: string
	// Specifies the subdirectory to load within the root directory. This is
	// useful if multiple systems share the same delivery mechanism. Envoy
	// configuration elements can be contained in a dedicated subdirectory.
	subdirectory?: string
	// :ref:`Append <config_runtime_local_disk_service_cluster_subdirs>` the
	// service cluster to the path under symlink root.
	append_service_cluster?: bool
}

// :ref:`Admin console runtime <config_runtime_admin>` layer.
#RuntimeLayer_AdminLayer: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v2.RuntimeLayer_AdminLayer"
}

// :ref:`Runtime Discovery Service (RTDS) <config_runtime_rtds>` layer.
#RuntimeLayer_RtdsLayer: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v2.RuntimeLayer_RtdsLayer"
	// Resource to subscribe to at *rtds_config* for the RTDS layer.
	name?: string
	// RTDS configuration source.
	rtds_config?: core.#ConfigSource
}
