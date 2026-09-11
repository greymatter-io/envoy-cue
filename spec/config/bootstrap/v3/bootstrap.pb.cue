package v3

import (
	structpb "envoyproxy.io/envoy-cue/spec/deps/protobuf/types/known/structpb"
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/metrics/v3"
	v32 "envoyproxy.io/envoy-cue/spec/config/trace/v3"
	v33 "envoyproxy.io/envoy-cue/spec/config/overload/v3"
	v34 "envoyproxy.io/envoy-cue/spec/config/accesslog/v3"
	v35 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
	v36 "envoyproxy.io/envoy-cue/spec/type/v3"
	v37 "envoyproxy.io/envoy-cue/spec/config/listener/v3"
	v38 "envoyproxy.io/envoy-cue/spec/config/cluster/v3"
	v39 "envoyproxy.io/envoy-cue/spec/extensions/transport_sockets/tls/v3"
)

// The events are fired in this order: “KILL“, “MULTIKILL“, “MEGAMISS“, “MISS“.
// Within an event type, actions execute in the order they are configured.
// For “KILL“/“MULTIKILL“ there is a default “PANIC“ that will run after the
// registered actions and kills the process if it wasn't already killed.
// It might be useful to specify several debug actions, and possibly an
// alternate “FATAL“ action.
#Watchdog_WatchdogAction_WatchdogEvent: "UNKNOWN" | "KILL" | "MULTIKILL" | "MEGAMISS" | "MISS"

Watchdog_WatchdogAction_WatchdogEvent_UNKNOWN:   "UNKNOWN"
Watchdog_WatchdogAction_WatchdogEvent_KILL:      "KILL"
Watchdog_WatchdogAction_WatchdogEvent_MULTIKILL: "MULTIKILL"
Watchdog_WatchdogAction_WatchdogEvent_MEGAMISS:  "MEGAMISS"
Watchdog_WatchdogAction_WatchdogEvent_MISS:      "MISS"

#CustomInlineHeader_InlineHeaderType: "REQUEST_HEADER" | "REQUEST_TRAILER" | "RESPONSE_HEADER" | "RESPONSE_TRAILER"

CustomInlineHeader_InlineHeaderType_REQUEST_HEADER:   "REQUEST_HEADER"
CustomInlineHeader_InlineHeaderType_REQUEST_TRAILER:  "REQUEST_TRAILER"
CustomInlineHeader_InlineHeaderType_RESPONSE_HEADER:  "RESPONSE_HEADER"
CustomInlineHeader_InlineHeaderType_RESPONSE_TRAILER: "RESPONSE_TRAILER"

#ApiListenerManager_ThreadingModel: "MAIN_THREAD_ONLY" | "STANDALONE_WORKER_THREAD"

ApiListenerManager_ThreadingModel_MAIN_THREAD_ONLY:         "MAIN_THREAD_ONLY"
ApiListenerManager_ThreadingModel_STANDALONE_WORKER_THREAD: "STANDALONE_WORKER_THREAD"

// Bootstrap :ref:`configuration overview <config_overview_bootstrap>`.
// [#next-free-field: 44]
#Bootstrap: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.Bootstrap"
	// Node identity to present to the management server and for instance
	// identification purposes (e.g. in generated headers).
	node?: v3.#Node
	// A list of :ref:`Node <envoy_v3_api_msg_config.core.v3.Node>` field names
	// that will be included in the context parameters of the effective
	// “xdstp://“ URL that is sent in a discovery request when resource
	// locators are used for LDS/CDS. Any non-string field will have its JSON
	// encoding set as the context parameter value, with the exception of
	// metadata, which will be flattened (see example below). The supported field
	// names are:
	// - “cluster“
	// - “id“
	// - “locality.region“
	// - “locality.sub_zone“
	// - “locality.zone“
	// - “metadata“
	// - “user_agent_build_version.metadata“
	// - “user_agent_build_version.version“
	// - “user_agent_name“
	// - “user_agent_version“
	//
	// The node context parameters act as a base layer dictionary for the context
	// parameters (i.e. more specific resource specific context parameters will
	// override). Field names will be prefixed with ````"udpa.node."```` when included in
	// context parameters.
	//
	// For example, if node_context_params is “["user_agent_name", "metadata"]“,
	// the implied context parameters might be::
	//
	//	node.user_agent_name: "envoy"
	//	node.metadata.foo: "{\"bar\": \"baz\"}"
	//	node.metadata.some: "42"
	//	node.metadata.thing: "\"thing\""
	//
	// [#not-implemented-hide:]
	node_context_params?: [...string]
	// Statically specified resources.
	static_resources?: #Bootstrap_StaticResources
	// xDS configuration sources.
	dynamic_resources?: #Bootstrap_DynamicResources
	// Configuration for the cluster manager which owns all upstream clusters
	// within the server.
	cluster_manager?: #ClusterManager
	// Health discovery service config option.
	// (:ref:`core.ApiConfigSource <envoy_v3_api_msg_config.core.v3.ApiConfigSource>`)
	hds_config?: v3.#ApiConfigSource
	// Optional file system path to search for startup flag files.
	flags_path?: string
	// Optional set of stats sinks.
	stats_sinks?: [...v31.#StatsSink]
	// Options to control behaviors of deferred creation compatible stats.
	deferred_stat_options?: #Bootstrap_DeferredStatOptions
	// Configuration for internal processing of stats.
	stats_config?: v31.#StatsConfig
	// Optional duration between flushes to configured stats sinks. For
	// performance reasons Envoy latches counters and only flushes counters and
	// gauges at a periodic interval. If not specified the default is “5000ms“ (“5“ seconds).
	// Only one of “stats_flush_interval“ or “stats_flush_on_admin“
	// can be set.
	// Duration must be at least “1ms“ and at most “5 min“.
	stats_flush_interval?: string
	// Flush stats to sinks only when queried for on the admin interface. If set,
	// a flush timer is not created. Only one of “stats_flush_on_admin“ or
	// “stats_flush_interval“ can be set.
	stats_flush_on_admin?: bool
	// Optional duration to perform metric eviction. At every interval, during the stats flush
	// the unused metrics are removed from the worker caches and the used metrics
	// are marked as unused. Must be a multiple of the “stats_flush_interval“.
	stats_eviction_interval?: string
	// Optional watchdog configuration.
	// This is for a single watchdog configuration for the entire system.
	// Deprecated in favor of “watchdogs“ which has finer granularity.
	//
	// Deprecated: Marked as deprecated in envoy/config/bootstrap/v3/bootstrap.proto.
	watchdog?: #Watchdog
	// Optional watchdogs configuration.
	// This is used for specifying different watchdogs for the different subsystems.
	// [#extension-category: envoy.guarddog_actions]
	watchdogs?: #Watchdogs
	// Configuration for an external tracing provider.
	//
	// .. attention::
	//
	//	This field has been deprecated in favor of :ref:`HttpConnectionManager.Tracing.provider
	//	<envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.Tracing.provider>`.
	//
	// Deprecated: Marked as deprecated in envoy/config/bootstrap/v3/bootstrap.proto.
	tracing?: v32.#Tracing
	// Configuration for the runtime configuration provider. If not
	// specified, a “null” provider will be used which will result in all defaults
	// being used.
	layered_runtime?: #LayeredRuntime
	// Configuration for the local administration HTTP server.
	admin?: #Admin
	// Optional overload manager configuration.
	overload_manager?: v33.#OverloadManager
	// Enable :ref:`stats for event dispatcher <operations_performance>`. Defaults to “false“.
	//
	// .. note::
	//
	//	This records a value for each iteration of the event loop on every thread. This
	//	should normally be minimal overhead, but when using
	//	:ref:`statsd <envoy_v3_api_msg_config.metrics.v3.StatsdSink>`, it will send each observed value
	//	over the wire individually because the statsd protocol doesn't have any way to represent a
	//	histogram summary. Be aware that this can be a very large volume of data.
	enable_dispatcher_stats?: bool
	// Optional string which will be used in lieu of “x-envoy“ in prefixing headers.
	//
	// For example, if this string is present and set to “X-Foo“, then “x-envoy-retry-on“ will be
	// transformed into “x-foo-retry-on“ etc.
	//
	// .. note::
	//
	//	This applies to the headers Envoy will generate, the headers Envoy will sanitize, and the
	//	headers Envoy will trust for core code and core extensions only. Be VERY careful making
	//	changes to this string, especially in multi-layer Envoy deployments or deployments using
	//	extensions which are not upstream.
	header_prefix?: string
	// Optional proxy version which will be used to set the value of :ref:`server.version statistic
	// <server_statistics>` if specified. Envoy will not process this value, it will be sent as is to
	// :ref:`stats sinks <envoy_v3_api_msg_config.metrics.v3.StatsSink>`.
	stats_server_version_override?: uint64
	// Always use “TCP“ queries instead of “UDP“ queries for DNS lookups.
	// This may be overridden on a per-cluster basis in “cds_config“,
	// when :ref:`dns_resolvers <envoy_v3_api_field_config.cluster.v3.Cluster.dns_resolvers>` and
	// :ref:`use_tcp_for_dns_lookups <envoy_v3_api_field_config.cluster.v3.Cluster.use_tcp_for_dns_lookups>` are
	// specified.
	// This field is deprecated in favor of “dns_resolution_config“
	// which aggregates all of the DNS resolver configuration in a single message.
	//
	// Deprecated: Marked as deprecated in envoy/config/bootstrap/v3/bootstrap.proto.
	use_tcp_for_dns_lookups?: bool
	// DNS resolution configuration which includes the underlying DNS resolver addresses and options.
	// This may be overridden on a per-cluster basis in “cds_config“, when
	// :ref:`dns_resolution_config <envoy_v3_api_field_config.cluster.v3.Cluster.dns_resolution_config>`
	// is specified.
	// This field is deprecated in favor of
	// :ref:`typed_dns_resolver_config <envoy_v3_api_field_config.bootstrap.v3.Bootstrap.typed_dns_resolver_config>`.
	//
	// Deprecated: Marked as deprecated in envoy/config/bootstrap/v3/bootstrap.proto.
	dns_resolution_config?: v3.#DnsResolutionConfig
	// DNS resolver type configuration extension. This extension can be used to configure “c-ares“, “apple“,
	// or any other DNS resolver types and the related parameters.
	// For example, an object of
	// :ref:`CaresDnsResolverConfig <envoy_v3_api_msg_extensions.network.dns_resolver.cares.v3.CaresDnsResolverConfig>`
	// can be packed into this “typed_dns_resolver_config“. This configuration replaces the
	// :ref:`dns_resolution_config <envoy_v3_api_field_config.bootstrap.v3.Bootstrap.dns_resolution_config>`
	// configuration.
	//
	// During the transition period when both “dns_resolution_config“ and “typed_dns_resolver_config“ exist,
	// when “typed_dns_resolver_config“ is in place, Envoy will use it and ignore “dns_resolution_config“.
	// When “typed_dns_resolver_config“ is missing, the default behavior is in place.
	// [#extension-category: envoy.network.dns_resolver]
	typed_dns_resolver_config?: v3.#TypedExtensionConfig
	// Specifies optional bootstrap extensions to be instantiated at startup time.
	// Each item contains extension specific configuration.
	// [#extension-category: envoy.bootstrap]
	bootstrap_extensions?: [...v3.#TypedExtensionConfig]
	// Specifies optional extensions instantiated at startup time and
	// invoked during crash time on the request that caused the crash.
	fatal_actions?: [...#FatalAction]
	// Configuration sources that will participate in
	// “xdstp://“ URL authority resolution. The algorithm is as
	// follows:
	//
	//  1. The authority field is taken from the “xdstp://“ URL, call
	//     this “resource_authority“.
	//  2. “resource_authority“ is compared against the authorities in any peer
	//     “ConfigSource“. The peer “ConfigSource“ is the configuration source
	//     message which would have been used unconditionally for resolution
	//     with opaque resource names. If there is a match with an authority, the
	//     peer “ConfigSource“ message is used.
	//  3. “resource_authority“ is compared sequentially with the authorities in
	//     each configuration source in “config_sources“. The first “ConfigSource“
	//     to match wins.
	//  4. As a fallback, if no configuration source matches, then
	//     “default_config_source“ is used.
	//  5. If “default_config_source“ is not specified, resolution fails.
	//
	// [#not-implemented-hide:]
	config_sources?: [...v3.#ConfigSource]
	// Default configuration source for “xdstp://“ URLs if all
	// other resolution fails.
	// [#not-implemented-hide:]
	default_config_source?: v3.#ConfigSource
	// Optional overriding of default socket interface. The value must be the name of one of the
	// socket interface factories initialized through a bootstrap extension
	default_socket_interface?: string
	// Global map of CertificateProvider instances. These instances are referred to by name in the
	// :ref:`CommonTlsContext.CertificateProviderInstance.instance_name
	// <envoy_v3_api_field_extensions.transport_sockets.tls.v3.CommonTlsContext.CertificateProviderInstance.instance_name>`
	// field.
	// [#not-implemented-hide:]
	certificate_provider_instances?: [string]: v3.#TypedExtensionConfig
	// Specifies a set of headers that need to be registered as inline header. This configuration
	// allows users to customize the inline headers on-demand at Envoy startup without modifying
	// Envoy's source code.
	//
	// .. note::
	//
	//	The ``set-cookie`` header cannot be registered as inline header.
	inline_headers?: [...#CustomInlineHeader]
	// Optional path to a file with performance tracing data created by “Perfetto“ SDK in binary
	// ProtoBuf format. The default value is “envoy.pftrace“.
	perf_tracing_file_path?: string
	// Optional overriding of default regex engine.
	// If the value is not specified, “Google RE2“ will be used by default.
	// [#extension-category: envoy.regex_engines]
	default_regex_engine?: v3.#TypedExtensionConfig
	// Optional XdsResourcesDelegate configuration, which allows plugging custom logic into both
	// fetch and load events during xDS processing.
	// If a value is not specified, no “XdsResourcesDelegate“ will be used.
	// TODO(abeyad): Add public-facing documentation.
	// [#not-implemented-hide:]
	xds_delegate_extension?: v3.#TypedExtensionConfig
	// Optional XdsConfigTracker configuration, which allows tracking xDS responses in external components,
	// e.g., external tracer or monitor. It provides the process point when receive, ingest, or fail to
	// process xDS resources and messages. If a value is not specified, no “XdsConfigTracker“ will be used.
	//
	// .. note::
	//
	//	There are no in-repo extensions currently, and the :repo:`XdsConfigTracker <envoy/config/xds_config_tracker.h>`
	//	interface should be implemented before using.
	//	See :repo:`xds_config_tracker_integration_test <test/integration/xds_config_tracker_integration_test.cc>`
	//	for an example usage of the interface.
	xds_config_tracker_extension?: v3.#TypedExtensionConfig
	// [#not-implemented-hide:]
	// This controls the type of listener manager configured for Envoy. Currently
	// Envoy only supports “ListenerManager“ for this field and Envoy Mobile
	// supports “ApiListenerManager“.
	listener_manager?: v3.#TypedExtensionConfig
	// Optional application log configuration.
	application_log_config?: #Bootstrap_ApplicationLogConfig
	// Optional gRPC async client manager config.
	grpc_async_client_manager_config?: #Bootstrap_GrpcAsyncClientManagerConfig
	// Optional configuration for memory allocation manager.
	// Memory releasing is only supported for `tcmalloc allocator <https://github.com/google/tcmalloc>`_.
	memory_allocator_manager?: #MemoryAllocatorManager
	// When enabled, Envoy pins each worker thread to a distinct CPU from the process affinity mask,
	// worker “i“ to the “i-th“ CPU in ascending order. This improves CPU cache and “NUMA“
	// locality for high concurrency deployments on bare metal. It is available on Linux only and is
	// ignored on other platforms. Pinning requires a worker count no greater than the number of CPUs
	// in the process affinity mask. When the worker count exceeds the available CPUs no worker is
	// pinned. Pinning is applied once when the workers start, so a later change to the process
	// affinity mask does not re-pin.
	//
	// Defaults to “false“.
	enable_worker_cpu_affinity?: bool
}

// Administration interface :ref:`operations documentation
// <operations_admin_interface>`.
// [#next-free-field: 8]
#Admin: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.Admin"
	// Configuration for :ref:`access logs <arch_overview_access_logs>`
	// emitted by the administration server.
	access_log?: [...v34.#AccessLog]
	// The path to write the access log for the administration server. If no
	// access log is desired specify “/dev/null“. This is only required if
	// :ref:`address <envoy_v3_api_field_config.bootstrap.v3.Admin.address>` is set.
	// Deprecated in favor of “access_log“ which offers more options.
	//
	// Deprecated: Marked as deprecated in envoy/config/bootstrap/v3/bootstrap.proto.
	access_log_path?: string
	// The CPU profiler output path for the administration server. If no profile
	// path is specified, the default is “/var/log/envoy/envoy.prof“.
	profile_path?: string
	// The TCP address that the administration server will listen on.
	// If not specified, Envoy will not start an administration server.
	address?: v3.#Address
	// Additional socket options that may not be present in Envoy source code or
	// precompiled binaries.
	socket_options?: [...v3.#SocketOption]
	// Indicates whether :ref:`global_downstream_max_connections <config_overload_manager_limiting_connections>`
	// should apply to the admin interface or not.
	ignore_global_conn_limit?: bool
	// List of admin paths that are accessible. If not specified, all admin endpoints are accessible.
	// Matchers are evaluated against the request path. For endpoints commonly queried with
	// parameters (for example “/stats?format=...“), prefer “prefix“ matchers.
	//
	// When specified, only paths in this list will be accessible, all others will return “HTTP 403 Forbidden“.
	//
	// Example:
	//
	// .. code-block:: yaml
	//
	//	allow_paths:
	//	- prefix: /stats
	//	- prefix: /config_dump
	//	- exact: /ready
	//	- prefix: /healthcheck
	allow_paths?: [...v35.#StringMatcher]
}

// Cluster manager :ref:`architecture overview <arch_overview_cluster_manager>`.
// [#next-free-field: 6]
#ClusterManager: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.ClusterManager"
	// Name of the local cluster (i.e., the cluster that owns the Envoy running
	// this configuration). In order to enable :ref:`zone aware routing
	// <arch_overview_load_balancing_zone_aware_routing>` this option must be set.
	// If “local_cluster_name“ is defined then :ref:`clusters
	// <envoy_v3_api_msg_config.cluster.v3.Cluster>` must be defined in the :ref:`Bootstrap
	// static cluster resources
	// <envoy_v3_api_field_config.bootstrap.v3.Bootstrap.StaticResources.clusters>`. This is unrelated to
	// the :option:`--service-cluster` option which does not `affect zone aware
	// routing <https://github.com/envoyproxy/envoy/issues/774>`_.
	local_cluster_name?: string
	// Optional global configuration for outlier detection.
	outlier_detection?: #ClusterManager_OutlierDetection
	// Optional configuration used to bind newly established upstream connections.
	// This may be overridden on a per-cluster basis by “upstream_bind_config“ in the “cds_config“.
	upstream_bind_config?: v3.#BindConfig
	// A management server endpoint to stream load stats to via
	// “StreamLoadStats“. This must have :ref:`api_type
	// <envoy_v3_api_field_config.core.v3.ApiConfigSource.api_type>` :ref:`GRPC
	// <envoy_v3_api_enum_value_config.core.v3.ApiConfigSource.ApiType.GRPC>`.
	load_stats_config?: v3.#ApiConfigSource
	// Whether the ClusterManager will create clusters on the worker threads
	// inline during requests. This will save memory and CPU cycles in cases where
	// there are lots of inactive clusters and “> 1“ worker thread.
	enable_deferred_cluster_creation?: bool
}

// Allows you to specify different watchdog configs for different subsystems.
// This allows finer tuned policies for the watchdog. If a subsystem is omitted
// the default values for that system will be used.
#Watchdogs: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.Watchdogs"
	// Watchdog for the main thread.
	main_thread_watchdog?: #Watchdog
	// Watchdog for the worker threads.
	worker_watchdog?: #Watchdog
}

// Envoy process watchdog configuration. When configured, this monitors for
// nonresponsive threads and kills the process after the configured thresholds.
// See the :ref:`watchdog documentation <operations_performance_watchdog>` for more information.
// [#next-free-field: 8]
#Watchdog: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.Watchdog"
	// Register actions that will fire on given Watchdog events.
	// See “WatchdogAction“ for priority of events.
	actions?: [...#Watchdog_WatchdogAction]
	// The duration after which Envoy counts a nonresponsive thread in the
	// “watchdog_miss“ statistic. If not specified the default is “200ms“.
	miss_timeout?: string
	// The duration after which Envoy counts a nonresponsive thread in the
	// “watchdog_mega_miss“ statistic. If not specified the default is “1000ms“.
	megamiss_timeout?: string
	// If a watched thread has been nonresponsive for this duration, assume a
	// programming error and kill the entire Envoy process. Set to “0“ to disable
	// kill behavior. If not specified the default is “0“ (disabled).
	kill_timeout?: string
	// Defines the maximum jitter used to adjust the “kill_timeout“ if “kill_timeout“ is
	// enabled. Enabling this feature would help to reduce risk of synchronized
	// watchdog kill events across proxies due to external triggers. Set to “0“ to
	// disable. If not specified the default is “0“ (disabled).
	max_kill_timeout_jitter?: string
	// If “max(2, ceil(registered_threads * Fraction(multikill_threshold)))“
	// threads have been nonresponsive for at least this duration kill the entire
	// Envoy process. Set to “0“ to disable this behavior. If not specified the
	// default is “0“ (disabled).
	multikill_timeout?: string
	// Sets the threshold for “multikill_timeout“ in terms of the percentage of
	// nonresponsive threads required for the “multikill_timeout“.
	// If not specified the default is “0“.
	multikill_threshold?: v36.#Percent
}

// Fatal actions to run while crashing. Actions can be safe (meaning they are
// async-signal safe) or unsafe. We run all safe actions before we run unsafe actions.
//
// .. note::
//
//	If using an unsafe action that could get stuck or deadlock, it is important to
//	have an out of band system to terminate the process.
//
// The interface for the extension is “Envoy::Server::Configuration::FatalAction“.
// “FatalAction“ extensions live in the “envoy.extensions.fatal_actions“ API
// namespace.
#FatalAction: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.FatalAction"
	// Extension specific configuration for the action. It's expected to conform
	// to the “Envoy::Server::Configuration::FatalAction“ interface.
	config?: v3.#TypedExtensionConfig
}

// Runtime :ref:`configuration overview <config_runtime>` (deprecated).
#Runtime: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.Runtime"
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
	base?: structpb.#Struct
}

// [#next-free-field: 6]
#RuntimeLayer: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.RuntimeLayer"
	// Descriptive name for the runtime layer. This is only used for the runtime
	// :http:get:`/runtime` output.
	name?: string
	// :ref:`Static runtime <config_runtime_bootstrap>` layer.
	// This follows the :ref:`runtime protobuf JSON representation encoding
	// <config_runtime_proto_json>`. Unlike static xDS resources, this static
	// layer is overridable by later layers in the runtime virtual filesystem.
	static_layer?: structpb.#Struct
	disk_layer?:   #RuntimeLayer_DiskLayer
	admin_layer?:  #RuntimeLayer_AdminLayer
	rtds_layer?:   #RuntimeLayer_RtdsLayer
}

// Runtime :ref:`configuration overview <config_runtime>`.
#LayeredRuntime: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.LayeredRuntime"
	// The :ref:`layers <config_runtime_layering>` of the runtime. This is ordered
	// such that later layers in the list overlay earlier entries.
	layers?: [...#RuntimeLayer]
}

// Used to specify the header that needs to be registered as an inline header.
//
// If request or response contain multiple headers with the same name and the header
// name is registered as an inline header, then multiple headers will be folded
// into one, and multiple header values will be concatenated by a suitable delimiter.
// The delimiter is generally a comma.
//
// For example, if “foo“ is registered as an inline header, and the headers contain
// the following two headers:
//
// .. code-block:: text
//
//	foo: bar
//	foo: eep
//
// Then they will eventually be folded into:
//
// .. code-block:: text
//
//	foo: bar, eep
//
// Inline headers provide O(1) search performance, but each inline header imposes
// an additional memory overhead on all instances of the corresponding type of
// HeaderMap or TrailerMap.
#CustomInlineHeader: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.CustomInlineHeader"
	// The name of the header that is expected to be set as the inline header.
	inline_header_name?: string
	// The type of the header that is expected to be set as the inline header.
	inline_header_type?: #CustomInlineHeader_InlineHeaderType
}

// [#next-free-field: 6]
#MemoryAllocatorManager: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.MemoryAllocatorManager"
	// Configures tcmalloc to perform background release of free memory in amount of bytes per “memory_release_interval“ interval.
	// If equals to “0“, no memory release will occur. Defaults to “0“.
	bytes_to_release?: uint64
	// Interval in milliseconds for memory releasing. If specified, during every
	// interval Envoy will try to release “bytes_to_release“ of free memory back to operating system for reuse.
	// Defaults to “1000“ milliseconds.
	memory_release_interval?: string
	// Sets the soft memory limit for tcmalloc. When the total memory used by tcmalloc exceeds this
	// limit, background release will be performed more aggressively to bring memory usage below the
	// limit. If not set, no soft memory limit is applied.
	//
	// .. note::
	//
	//	This is currently only supported with tcmalloc and not with ``gperftools``.
	soft_memory_limit_bytes?: uint64
	// Sets the maximum per-CPU cache size in bytes for tcmalloc. Smaller values reduce per-CPU
	// memory overhead at the cost of increased contention on the central free list. If not set,
	// tcmalloc's default is used.
	//
	// .. note::
	//
	//	This is currently only supported with tcmalloc and not with ``gperftools``.
	max_per_cpu_cache_size_bytes?: uint32
	// The threshold of unfreed memory in bytes that triggers the heap shrinker to release memory
	// back to the OS. When the difference between physical memory used and application-allocated
	// memory exceeds this threshold, free memory is released.
	//
	// Defaults to “104857600“ (100 MB).
	max_unfreed_memory_bytes?: uint64
}

// A placeholder proto so that users can explicitly configure the standard
// Listener Manager via the bootstrap's :ref:`listener_manager <envoy_v3_api_field_config.bootstrap.v3.Bootstrap.listener_manager>`.
// [#not-implemented-hide:]
#ListenerManager: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.ListenerManager"
}

// A placeholder proto so that users can explicitly configure the standard
// Validation Listener Manager via the bootstrap's :ref:`listener_manager <envoy_v3_api_field_config.bootstrap.v3.Bootstrap.listener_manager>`.
// [#not-implemented-hide:]
#ValidationListenerManager: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.ValidationListenerManager"
}

// A placeholder proto so that users can explicitly configure the API
// Listener Manager via the bootstrap's :ref:`listener_manager <envoy_v3_api_field_config.bootstrap.v3.Bootstrap.listener_manager>`.
// [#not-implemented-hide:]
#ApiListenerManager: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.ApiListenerManager"
	// Default to MainThreadOnly.
	threading_model?: #ApiListenerManager_ThreadingModel
}

#Bootstrap_StaticResources: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.Bootstrap_StaticResources"
	// Static :ref:`Listeners <envoy_v3_api_msg_config.listener.v3.Listener>`. These listeners are
	// available regardless of LDS configuration.
	listeners?: [...v37.#Listener]
	// If a network based configuration source is specified for :ref:`cds_config
	// <envoy_v3_api_field_config.bootstrap.v3.Bootstrap.DynamicResources.cds_config>`, it's necessary
	// to have some initial cluster definitions available to allow Envoy to know
	// how to speak to the management server.
	clusters?: [...v38.#Cluster]
	// These static secrets can be used by :ref:`SdsSecretConfig
	// <envoy_v3_api_msg_extensions.transport_sockets.tls.v3.SdsSecretConfig>`
	secrets?: [...v39.#Secret]
}

// [#next-free-field: 7]
#Bootstrap_DynamicResources: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.Bootstrap_DynamicResources"
	// All :ref:`Listeners <envoy_v3_api_msg_config.listener.v3.Listener>` are provided by a single
	// :ref:`LDS <arch_overview_dynamic_config_lds>` configuration source.
	lds_config?: v3.#ConfigSource
	// “xdstp://“ resource locator for listener collection.
	// [#not-implemented-hide:]
	lds_resources_locator?: string
	// All post-bootstrap :ref:`Cluster <envoy_v3_api_msg_config.cluster.v3.Cluster>` definitions are
	// provided by a single :ref:`CDS <arch_overview_dynamic_config_cds>`
	// configuration source.
	cds_config?: v3.#ConfigSource
	// “xdstp://“ resource locator for cluster collection.
	// [#not-implemented-hide:]
	cds_resources_locator?: string
	// A single :ref:`ADS <config_overview_ads>` source may be optionally
	// specified. This must have :ref:`api_type
	// <envoy_v3_api_field_config.core.v3.ApiConfigSource.api_type>` :ref:`GRPC
	// <envoy_v3_api_enum_value_config.core.v3.ApiConfigSource.ApiType.GRPC>`. Only
	// :ref:`ConfigSources <envoy_v3_api_msg_config.core.v3.ConfigSource>` that have
	// the :ref:`ads <envoy_v3_api_field_config.core.v3.ConfigSource.ads>` field set will be
	// streamed on the ADS channel.
	ads_config?: v3.#ApiConfigSource
}

#Bootstrap_ApplicationLogConfig: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.Bootstrap_ApplicationLogConfig"
	// Optional field to set the application logs format. If this field is set, it will override
	// the default log format. Setting both this field and :option:`--log-format` command line
	// option is not allowed, and will cause a bootstrap error.
	log_format?: #Bootstrap_ApplicationLogConfig_LogFormat
}

#Bootstrap_DeferredStatOptions: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.Bootstrap_DeferredStatOptions"
	// When the flag is enabled, Envoy will lazily initialize a subset of the stats (see below).
	// This will save memory and CPU cycles when creating the objects that own these stats, if those
	// stats are never referenced throughout the lifetime of the process. However, it will incur additional
	// memory overhead for these objects, and a small increase of CPU usage when at least one of the stats
	// is updated for the first time.
	//
	// Groups of stats that will be lazily initialized:
	//
	//   - Cluster traffic stats: a subgroup of the :ref:`cluster statistics <config_cluster_manager_cluster_stats>`
	//     that are used when requests are routed to the cluster.
	enable_deferred_creation_stats?: bool
}

#Bootstrap_GrpcAsyncClientManagerConfig: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.Bootstrap_GrpcAsyncClientManagerConfig"
	// Optional field to set the expiration time for the cached gRPC client object.
	// The minimal value is “5s“ and the default is “50s“.
	max_cached_entry_idle_duration?: string
}

#Bootstrap_ApplicationLogConfig_LogFormat: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.Bootstrap_ApplicationLogConfig_LogFormat"
	// Flush application logs in JSON format. The configured JSON struct can
	// support all the format flags specified in the :option:`--log-format`
	// command line options section, except for the “%v“ and “%_“ flags.
	json_format?: structpb.#Struct
	// Flush application log in a format defined by a string. The text format
	// can support all the format flags specified in the :option:`--log-format`
	// command line option section.
	text_format?: string
}

#ClusterManager_OutlierDetection: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.ClusterManager_OutlierDetection"
	// Specifies the path to the outlier event log.
	event_log_path?: string
	// [#not-implemented-hide:]
	// The gRPC service for the outlier detection event service.
	// If empty, outlier detection events won't be sent to a remote endpoint.
	event_service?: v3.#EventServiceConfig
}

#Watchdog_WatchdogAction: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.Watchdog_WatchdogAction"
	// Extension specific configuration for the action.
	config?: v3.#TypedExtensionConfig
	event?:  #Watchdog_WatchdogAction_WatchdogEvent
}

// :ref:`Disk runtime <config_runtime_local_disk>` layer.
#RuntimeLayer_DiskLayer: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.RuntimeLayer_DiskLayer"
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
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.RuntimeLayer_AdminLayer"
}

// :ref:`Runtime Discovery Service (RTDS) <config_runtime_rtds>` layer.
#RuntimeLayer_RtdsLayer: {
	"@type": "type.googleapis.com/envoy.config.bootstrap.v3.RuntimeLayer_RtdsLayer"
	// Resource to subscribe to at the “rtds_config“ for the RTDS layer.
	name?: string
	// RTDS configuration source.
	rtds_config?: v3.#ConfigSource
}
