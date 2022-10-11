package core

// xDS API version. This is used to describe both resource and transport
// protocol versions (in distinct configuration fields).
#ApiVersion: "AUTO" | "V2" | "V3"

ApiVersion_AUTO: "AUTO"
ApiVersion_V2:   "V2"
ApiVersion_V3:   "V3"

// APIs may be fetched via either REST or gRPC.
#ApiConfigSource_ApiType: "UNSUPPORTED_REST_LEGACY" | "REST" | "GRPC" | "DELTA_GRPC"

ApiConfigSource_ApiType_UNSUPPORTED_REST_LEGACY: "UNSUPPORTED_REST_LEGACY"
ApiConfigSource_ApiType_REST:                    "REST"
ApiConfigSource_ApiType_GRPC:                    "GRPC"
ApiConfigSource_ApiType_DELTA_GRPC:              "DELTA_GRPC"

// API configuration source. This identifies the API type and cluster that Envoy
// will use to fetch an xDS API.
// [#next-free-field: 9]
#ApiConfigSource: {
	"@type": "type.googleapis.com/envoy.api.v2.core.ApiConfigSource"
	// API type (gRPC, REST, delta gRPC)
	api_type?: #ApiConfigSource_ApiType
	// API version for xDS transport protocol. This describes the xDS gRPC/REST
	// endpoint and version of [Delta]DiscoveryRequest/Response used on the wire.
	transport_api_version?: #ApiVersion
	// Cluster names should be used only with REST. If > 1
	// cluster is defined, clusters will be cycled through if any kind of failure
	// occurs.
	//
	// .. note::
	//
	//  The cluster with name ``cluster_name`` must be statically defined and its
	//  type must not be ``EDS``.
	cluster_names?: [...string]
	// Multiple gRPC services be provided for GRPC. If > 1 cluster is defined,
	// services will be cycled through if any kind of failure occurs.
	grpc_services?: [...#GrpcService]
	// For REST APIs, the delay between successive polls.
	refresh_delay?: string
	// For REST APIs, the request timeout. If not set, a default value of 1s will be used.
	request_timeout?: string
	// For GRPC APIs, the rate limit settings. If present, discovery requests made by Envoy will be
	// rate limited.
	rate_limit_settings?: #RateLimitSettings
	// Skip the node identifier in subsequent discovery requests for streaming gRPC config types.
	set_node_on_first_message_only?: bool
}

// Aggregated Discovery Service (ADS) options. This is currently empty, but when
// set in :ref:`ConfigSource <envoy_api_msg_core.ConfigSource>` can be used to
// specify that ADS is to be used.
#AggregatedConfigSource: {
	"@type": "type.googleapis.com/envoy.api.v2.core.AggregatedConfigSource"
}

// [#not-implemented-hide:]
// Self-referencing config source options. This is currently empty, but when
// set in :ref:`ConfigSource <envoy_api_msg_core.ConfigSource>` can be used to
// specify that other data can be obtained from the same server.
#SelfConfigSource: {
	"@type": "type.googleapis.com/envoy.api.v2.core.SelfConfigSource"
	// API version for xDS transport protocol. This describes the xDS gRPC/REST
	// endpoint and version of [Delta]DiscoveryRequest/Response used on the wire.
	transport_api_version?: #ApiVersion
}

// Rate Limit settings to be applied for discovery requests made by Envoy.
#RateLimitSettings: {
	"@type": "type.googleapis.com/envoy.api.v2.core.RateLimitSettings"
	// Maximum number of tokens to be used for rate limiting discovery request calls. If not set, a
	// default value of 100 will be used.
	max_tokens?: uint32
	// Rate at which tokens will be filled per second. If not set, a default fill rate of 10 tokens
	// per second will be used.
	fill_rate?: float64
}

// Configuration for :ref:`listeners <config_listeners>`, :ref:`clusters
// <config_cluster_manager>`, :ref:`routes
// <envoy_api_msg_RouteConfiguration>`, :ref:`endpoints
// <arch_overview_service_discovery>` etc. may either be sourced from the
// filesystem or from an xDS API source. Filesystem configs are watched with
// inotify for updates.
// [#next-free-field: 7]
#ConfigSource: {
	"@type": "type.googleapis.com/envoy.api.v2.core.ConfigSource"
	// Path on the filesystem to source and watch for configuration updates.
	// When sourcing configuration for :ref:`secret <envoy_api_msg_auth.Secret>`,
	// the certificate and key files are also watched for updates.
	//
	// .. note::
	//
	//  The path to the source must exist at config load time.
	//
	// .. note::
	//
	//   Envoy will only watch the file path for *moves.* This is because in general only moves
	//   are atomic. The same method of swapping files as is demonstrated in the
	//   :ref:`runtime documentation <config_runtime_symbolic_link_swap>` can be used here also.
	path?: string
	// API configuration source.
	api_config_source?: #ApiConfigSource
	// When set, ADS will be used to fetch resources. The ADS API configuration
	// source in the bootstrap configuration is used.
	ads?: #AggregatedConfigSource
	// [#not-implemented-hide:]
	// When set, the client will access the resources from the same server it got the
	// ConfigSource from, although not necessarily from the same stream. This is similar to the
	// :ref:`ads<envoy_api_field.ConfigSource.ads>` field, except that the client may use a
	// different stream to the same server. As a result, this field can be used for things
	// like LRS that cannot be sent on an ADS stream. It can also be used to link from (e.g.)
	// LDS to RDS on the same server without requiring the management server to know its name
	// or required credentials.
	// [#next-major-version: In xDS v3, consider replacing the ads field with this one, since
	// this field can implicitly mean to use the same stream in the case where the ConfigSource
	// is provided via ADS and the specified data can also be obtained via ADS.]
	self?: #SelfConfigSource
	// When this timeout is specified, Envoy will wait no longer than the specified time for first
	// config response on this xDS subscription during the :ref:`initialization process
	// <arch_overview_initialization>`. After reaching the timeout, Envoy will move to the next
	// initialization phase, even if the first config is not delivered yet. The timer is activated
	// when the xDS API subscription starts, and is disarmed on first config update or on error. 0
	// means no timeout - Envoy will wait indefinitely for the first xDS config (unless another
	// timeout applies). The default is 15s.
	initial_fetch_timeout?: string
	// API version for xDS resources. This implies the type URLs that the client
	// will request for resources and the resource type that the client will in
	// turn expect to be delivered.
	resource_api_version?: #ApiVersion
}
