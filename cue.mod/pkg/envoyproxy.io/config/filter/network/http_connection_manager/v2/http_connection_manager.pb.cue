package v2

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
	_type "envoyproxy.io/type"
	core "envoyproxy.io/api/v2/core"
	v2 "envoyproxy.io/config/filter/accesslog/v2"
	v21 "envoyproxy.io/api/v2"
	v22 "envoyproxy.io/type/tracing/v2"
	v23 "envoyproxy.io/config/trace/v2"
)

#HttpConnectionManager_CodecType: "AUTO" | "HTTP1" | "HTTP2" | "HTTP3"

HttpConnectionManager_CodecType_AUTO:  "AUTO"
HttpConnectionManager_CodecType_HTTP1: "HTTP1"
HttpConnectionManager_CodecType_HTTP2: "HTTP2"
HttpConnectionManager_CodecType_HTTP3: "HTTP3"

#HttpConnectionManager_ServerHeaderTransformation: "OVERWRITE" | "APPEND_IF_ABSENT" | "PASS_THROUGH"

HttpConnectionManager_ServerHeaderTransformation_OVERWRITE:        "OVERWRITE"
HttpConnectionManager_ServerHeaderTransformation_APPEND_IF_ABSENT: "APPEND_IF_ABSENT"
HttpConnectionManager_ServerHeaderTransformation_PASS_THROUGH:     "PASS_THROUGH"

// How to handle the :ref:`config_http_conn_man_headers_x-forwarded-client-cert` (XFCC) HTTP
// header.
#HttpConnectionManager_ForwardClientCertDetails: "SANITIZE" | "FORWARD_ONLY" | "APPEND_FORWARD" | "SANITIZE_SET" | "ALWAYS_FORWARD_ONLY"

HttpConnectionManager_ForwardClientCertDetails_SANITIZE:            "SANITIZE"
HttpConnectionManager_ForwardClientCertDetails_FORWARD_ONLY:        "FORWARD_ONLY"
HttpConnectionManager_ForwardClientCertDetails_APPEND_FORWARD:      "APPEND_FORWARD"
HttpConnectionManager_ForwardClientCertDetails_SANITIZE_SET:        "SANITIZE_SET"
HttpConnectionManager_ForwardClientCertDetails_ALWAYS_FORWARD_ONLY: "ALWAYS_FORWARD_ONLY"

#HttpConnectionManager_Tracing_OperationName: "INGRESS" | "EGRESS"

HttpConnectionManager_Tracing_OperationName_INGRESS: "INGRESS"
HttpConnectionManager_Tracing_OperationName_EGRESS:  "EGRESS"

// [#next-free-field: 37]
#HttpConnectionManager: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.HttpConnectionManager"
	// Supplies the type of codec that the connection manager should use.
	codec_type?: #HttpConnectionManager_CodecType
	// The human readable prefix to use when emitting statistics for the
	// connection manager. See the :ref:`statistics documentation <config_http_conn_man_stats>` for
	// more information.
	stat_prefix?: string
	// The connection manager’s route table will be dynamically loaded via the RDS API.
	rds?: #Rds
	// The route table for the connection manager is static and is specified in this property.
	route_config?: v21.#RouteConfiguration
	// A route table will be dynamically assigned to each request based on request attributes
	// (e.g., the value of a header). The "routing scopes" (i.e., route tables) and "scope keys" are
	// specified in this message.
	scoped_routes?: #ScopedRoutes
	// A list of individual HTTP filters that make up the filter chain for
	// requests made to the connection manager. :ref:`Order matters <arch_overview_http_filters_ordering>`
	// as the filters are processed sequentially as request events happen.
	http_filters?: [...#HttpFilter]
	// Whether the connection manager manipulates the :ref:`config_http_conn_man_headers_user-agent`
	// and :ref:`config_http_conn_man_headers_downstream-service-cluster` headers. See the linked
	// documentation for more information. Defaults to false.
	add_user_agent?: bool
	// Presence of the object defines whether the connection manager
	// emits :ref:`tracing <arch_overview_tracing>` data to the :ref:`configured tracing provider
	// <envoy_api_msg_config.trace.v2.Tracing>`.
	tracing?: #HttpConnectionManager_Tracing
	// Additional settings for HTTP requests handled by the connection manager. These will be
	// applicable to both HTTP1 and HTTP2 requests.
	common_http_protocol_options?: core.#HttpProtocolOptions
	// Additional HTTP/1 settings that are passed to the HTTP/1 codec.
	http_protocol_options?: core.#Http1ProtocolOptions
	// Additional HTTP/2 settings that are passed directly to the HTTP/2 codec.
	http2_protocol_options?: core.#Http2ProtocolOptions
	// An optional override that the connection manager will write to the server
	// header in responses. If not set, the default is *envoy*.
	server_name?: string
	// Defines the action to be applied to the Server header on the response path.
	// By default, Envoy will overwrite the header with the value specified in
	// server_name.
	server_header_transformation?: #HttpConnectionManager_ServerHeaderTransformation
	// The maximum request headers size for incoming connections.
	// If unconfigured, the default max request headers allowed is 60 KiB.
	// Requests that exceed this limit will receive a 431 response.
	max_request_headers_kb?: uint32
	// The idle timeout for connections managed by the connection manager. The
	// idle timeout is defined as the period in which there are no active
	// requests. If not set, there is no idle timeout. When the idle timeout is
	// reached the connection will be closed. If the connection is an HTTP/2
	// connection a drain sequence will occur prior to closing the connection.
	// This field is deprecated. Use :ref:`idle_timeout
	// <envoy_api_field_config.filter.network.http_connection_manager.v2.HttpConnectionManager.common_http_protocol_options>`
	// instead.
	//
	// Deprecated: Do not use.
	idle_timeout?: string
	// The stream idle timeout for connections managed by the connection manager.
	// If not specified, this defaults to 5 minutes. The default value was selected
	// so as not to interfere with any smaller configured timeouts that may have
	// existed in configurations prior to the introduction of this feature, while
	// introducing robustness to TCP connections that terminate without a FIN.
	//
	// This idle timeout applies to new streams and is overridable by the
	// :ref:`route-level idle_timeout
	// <envoy_api_field_route.RouteAction.idle_timeout>`. Even on a stream in
	// which the override applies, prior to receipt of the initial request
	// headers, the :ref:`stream_idle_timeout
	// <envoy_api_field_config.filter.network.http_connection_manager.v2.HttpConnectionManager.stream_idle_timeout>`
	// applies. Each time an encode/decode event for headers or data is processed
	// for the stream, the timer will be reset. If the timeout fires, the stream
	// is terminated with a 408 Request Timeout error code if no upstream response
	// header has been received, otherwise a stream reset occurs.
	//
	// This timeout also specifies the amount of time that Envoy will wait for the peer to open enough
	// window to write any remaining stream data once the entirety of stream data (local end stream is
	// true) has been buffered pending available window. In other words, this timeout defends against
	// a peer that does not release enough window to completely write the stream, even though all
	// data has been proxied within available flow control windows. If the timeout is hit in this
	// case, the :ref:`tx_flush_timeout <config_http_conn_man_stats_per_codec>` counter will be
	// incremented. Note that :ref:`max_stream_duration
	// <envoy_api_field_core.HttpProtocolOptions.max_stream_duration>` does not apply to this corner
	// case.
	//
	// Note that it is possible to idle timeout even if the wire traffic for a stream is non-idle, due
	// to the granularity of events presented to the connection manager. For example, while receiving
	// very large request headers, it may be the case that there is traffic regularly arriving on the
	// wire while the connection manage is only able to observe the end-of-headers event, hence the
	// stream may still idle timeout.
	//
	// A value of 0 will completely disable the connection manager stream idle
	// timeout, although per-route idle timeout overrides will continue to apply.
	stream_idle_timeout?: string
	// The amount of time that Envoy will wait for the entire request to be received.
	// The timer is activated when the request is initiated, and is disarmed when the last byte of the
	// request is sent upstream (i.e. all decoding filters have processed the request), OR when the
	// response is initiated. If not specified or set to 0, this timeout is disabled.
	request_timeout?: string
	// The time that Envoy will wait between sending an HTTP/2 “shutdown
	// notification” (GOAWAY frame with max stream ID) and a final GOAWAY frame.
	// This is used so that Envoy provides a grace period for new streams that
	// race with the final GOAWAY frame. During this grace period, Envoy will
	// continue to accept new streams. After the grace period, a final GOAWAY
	// frame is sent and Envoy will start refusing new streams. Draining occurs
	// both when a connection hits the idle timeout or during general server
	// draining. The default grace period is 5000 milliseconds (5 seconds) if this
	// option is not specified.
	drain_timeout?: string
	// The delayed close timeout is for downstream connections managed by the HTTP connection manager.
	// It is defined as a grace period after connection close processing has been locally initiated
	// during which Envoy will wait for the peer to close (i.e., a TCP FIN/RST is received by Envoy
	// from the downstream connection) prior to Envoy closing the socket associated with that
	// connection.
	// NOTE: This timeout is enforced even when the socket associated with the downstream connection
	// is pending a flush of the write buffer. However, any progress made writing data to the socket
	// will restart the timer associated with this timeout. This means that the total grace period for
	// a socket in this state will be
	// <total_time_waiting_for_write_buffer_flushes>+<delayed_close_timeout>.
	//
	// Delaying Envoy's connection close and giving the peer the opportunity to initiate the close
	// sequence mitigates a race condition that exists when downstream clients do not drain/process
	// data in a connection's receive buffer after a remote close has been detected via a socket
	// write(). This race leads to such clients failing to process the response code sent by Envoy,
	// which could result in erroneous downstream processing.
	//
	// If the timeout triggers, Envoy will close the connection's socket.
	//
	// The default timeout is 1000 ms if this option is not specified.
	//
	// .. NOTE::
	//    To be useful in avoiding the race condition described above, this timeout must be set
	//    to *at least* <max round trip time expected between clients and Envoy>+<100ms to account for
	//    a reasonable "worst" case processing time for a full iteration of Envoy's event loop>.
	//
	// .. WARNING::
	//    A value of 0 will completely disable delayed close processing. When disabled, the downstream
	//    connection's socket will be closed immediately after the write flush is completed or will
	//    never close if the write flush does not complete.
	delayed_close_timeout?: string
	// Configuration for :ref:`HTTP access logs <arch_overview_access_logs>`
	// emitted by the connection manager.
	access_log?: [...v2.#AccessLog]
	// If set to true, the connection manager will use the real remote address
	// of the client connection when determining internal versus external origin and manipulating
	// various headers. If set to false or absent, the connection manager will use the
	// :ref:`config_http_conn_man_headers_x-forwarded-for` HTTP header. See the documentation for
	// :ref:`config_http_conn_man_headers_x-forwarded-for`,
	// :ref:`config_http_conn_man_headers_x-envoy-internal`, and
	// :ref:`config_http_conn_man_headers_x-envoy-external-address` for more information.
	use_remote_address?: bool
	// The number of additional ingress proxy hops from the right side of the
	// :ref:`config_http_conn_man_headers_x-forwarded-for` HTTP header to trust when
	// determining the origin client's IP address. The default is zero if this option
	// is not specified. See the documentation for
	// :ref:`config_http_conn_man_headers_x-forwarded-for` for more information.
	xff_num_trusted_hops?: uint32
	// Configures what network addresses are considered internal for stats and header sanitation
	// purposes. If unspecified, only RFC1918 IP addresses will be considered internal.
	// See the documentation for :ref:`config_http_conn_man_headers_x-envoy-internal` for more
	// information about internal/external addresses.
	internal_address_config?: #HttpConnectionManager_InternalAddressConfig
	// If set, Envoy will not append the remote address to the
	// :ref:`config_http_conn_man_headers_x-forwarded-for` HTTP header. This may be used in
	// conjunction with HTTP filters that explicitly manipulate XFF after the HTTP connection manager
	// has mutated the request headers. While :ref:`use_remote_address
	// <envoy_api_field_config.filter.network.http_connection_manager.v2.HttpConnectionManager.use_remote_address>`
	// will also suppress XFF addition, it has consequences for logging and other
	// Envoy uses of the remote address, so *skip_xff_append* should be used
	// when only an elision of XFF addition is intended.
	skip_xff_append?: bool
	// Via header value to append to request and response headers. If this is
	// empty, no via header will be appended.
	via?: string
	// Whether the connection manager will generate the :ref:`x-request-id
	// <config_http_conn_man_headers_x-request-id>` header if it does not exist. This defaults to
	// true. Generating a random UUID4 is expensive so in high throughput scenarios where this feature
	// is not desired it can be disabled.
	generate_request_id?: bool
	// Whether the connection manager will keep the :ref:`x-request-id
	// <config_http_conn_man_headers_x-request-id>` header if passed for a request that is edge
	// (Edge request is the request from external clients to front Envoy) and not reset it, which
	// is the current Envoy behaviour. This defaults to false.
	preserve_external_request_id?: bool
	// How to handle the :ref:`config_http_conn_man_headers_x-forwarded-client-cert` (XFCC) HTTP
	// header.
	forward_client_cert_details?: #HttpConnectionManager_ForwardClientCertDetails
	// This field is valid only when :ref:`forward_client_cert_details
	// <envoy_api_field_config.filter.network.http_connection_manager.v2.HttpConnectionManager.forward_client_cert_details>`
	// is APPEND_FORWARD or SANITIZE_SET and the client connection is mTLS. It specifies the fields in
	// the client certificate to be forwarded. Note that in the
	// :ref:`config_http_conn_man_headers_x-forwarded-client-cert` header, *Hash* is always set, and
	// *By* is always set when the client certificate presents the URI type Subject Alternative Name
	// value.
	set_current_client_cert_details?: #HttpConnectionManager_SetCurrentClientCertDetails
	// If proxy_100_continue is true, Envoy will proxy incoming "Expect:
	// 100-continue" headers upstream, and forward "100 Continue" responses
	// downstream. If this is false or not set, Envoy will instead strip the
	// "Expect: 100-continue" header, and send a "100 Continue" response itself.
	proxy_100_continue?: bool
	// If
	// :ref:`use_remote_address
	// <envoy_api_field_config.filter.network.http_connection_manager.v2.HttpConnectionManager.use_remote_address>`
	// is true and represent_ipv4_remote_address_as_ipv4_mapped_ipv6 is true and the remote address is
	// an IPv4 address, the address will be mapped to IPv6 before it is appended to *x-forwarded-for*.
	// This is useful for testing compatibility of upstream services that parse the header value. For
	// example, 50.0.0.1 is represented as ::FFFF:50.0.0.1. See `IPv4-Mapped IPv6 Addresses
	// <https://tools.ietf.org/html/rfc4291#section-2.5.5.2>`_ for details. This will also affect the
	// :ref:`config_http_conn_man_headers_x-envoy-external-address` header. See
	// :ref:`http_connection_manager.represent_ipv4_remote_address_as_ipv4_mapped_ipv6
	// <config_http_conn_man_runtime_represent_ipv4_remote_address_as_ipv4_mapped_ipv6>` for runtime
	// control.
	// [#not-implemented-hide:]
	represent_ipv4_remote_address_as_ipv4_mapped_ipv6?: bool
	upgrade_configs?: [...#HttpConnectionManager_UpgradeConfig]
	// Should paths be normalized according to RFC 3986 before any processing of
	// requests by HTTP filters or routing? This affects the upstream *:path* header
	// as well. For paths that fail this check, Envoy will respond with 400 to
	// paths that are malformed. This defaults to false currently but will default
	// true in the future. When not specified, this value may be overridden by the
	// runtime variable
	// :ref:`http_connection_manager.normalize_path<config_http_conn_man_runtime_normalize_path>`.
	// See `Normalization and Comparison <https://tools.ietf.org/html/rfc3986#section-6>`_
	// for details of normalization.
	// Note that Envoy does not perform
	// `case normalization <https://tools.ietf.org/html/rfc3986#section-6.2.2.1>`_
	normalize_path?: bool
	// Determines if adjacent slashes in the path are merged into one before any processing of
	// requests by HTTP filters or routing. This affects the upstream *:path* header as well. Without
	// setting this option, incoming requests with path `//dir///file` will not match against route
	// with `prefix` match set to `/dir`. Defaults to `false`. Note that slash merging is not part of
	// `HTTP spec <https://tools.ietf.org/html/rfc3986>`_ and is provided for convenience.
	merge_slashes?: bool
	// The configuration of the request ID extension. This includes operations such as
	// generation, validation, and associated tracing operations.
	//
	// If not set, Envoy uses the default UUID-based behavior:
	//
	// 1. Request ID is propagated using *x-request-id* header.
	//
	// 2. Request ID is a universally unique identifier (UUID).
	//
	// 3. Tracing decision (sampled, forced, etc) is set in 14th byte of the UUID.
	request_id_extension?: #RequestIDExtension
}

#Rds: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.Rds"
	// Configuration source specifier for RDS.
	config_source?: core.#ConfigSource
	// The name of the route configuration. This name will be passed to the RDS
	// API. This allows an Envoy configuration with multiple HTTP listeners (and
	// associated HTTP connection manager filters) to use different route
	// configurations.
	route_config_name?: string
}

// This message is used to work around the limitations with 'oneof' and repeated fields.
#ScopedRouteConfigurationsList: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.ScopedRouteConfigurationsList"
	scoped_route_configurations?: [...v21.#ScopedRouteConfiguration]
}

// [#next-free-field: 6]
#ScopedRoutes: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.ScopedRoutes"
	// The name assigned to the scoped routing configuration.
	name?: string
	// The algorithm to use for constructing a scope key for each request.
	scope_key_builder?: #ScopedRoutes_ScopeKeyBuilder
	// Configuration source specifier for RDS.
	// This config source is used to subscribe to RouteConfiguration resources specified in
	// ScopedRouteConfiguration messages.
	rds_config_source?: core.#ConfigSource
	// The set of routing scopes corresponding to the HCM. A scope is assigned to a request by
	// matching a key constructed from the request's attributes according to the algorithm specified
	// by the
	// :ref:`ScopeKeyBuilder<envoy_api_msg_config.filter.network.http_connection_manager.v2.ScopedRoutes.ScopeKeyBuilder>`
	// in this message.
	scoped_route_configurations_list?: #ScopedRouteConfigurationsList
	// The set of routing scopes associated with the HCM will be dynamically loaded via the SRDS
	// API. A scope is assigned to a request by matching a key constructed from the request's
	// attributes according to the algorithm specified by the
	// :ref:`ScopeKeyBuilder<envoy_api_msg_config.filter.network.http_connection_manager.v2.ScopedRoutes.ScopeKeyBuilder>`
	// in this message.
	scoped_rds?: #ScopedRds
}

#ScopedRds: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.ScopedRds"
	// Configuration source specifier for scoped RDS.
	scoped_rds_config_source?: core.#ConfigSource
}

#HttpFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.HttpFilter"
	// The name of the filter to instantiate. The name must match a
	// :ref:`supported filter <config_http_filters>`.
	name?: string
	// Deprecated: Do not use.
	config?:       _struct.#Struct
	typed_config?: _
}

#RequestIDExtension: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.RequestIDExtension"
	// Request ID extension specific configuration.
	typed_config?: _
}

// [#next-free-field: 10]
#HttpConnectionManager_Tracing: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.HttpConnectionManager_Tracing"
	// The span name will be derived from this field. If
	// :ref:`traffic_direction <envoy_api_field_Listener.traffic_direction>` is
	// specified on the parent listener, then it is used instead of this field.
	//
	// .. attention::
	//  This field has been deprecated in favor of `traffic_direction`.
	//
	// Deprecated: Do not use.
	operation_name?: #HttpConnectionManager_Tracing_OperationName
	// A list of header names used to create tags for the active span. The header name is used to
	// populate the tag name, and the header value is used to populate the tag value. The tag is
	// created if the specified header name is present in the request's headers.
	//
	// .. attention::
	//  This field has been deprecated in favor of :ref:`custom_tags
	//  <envoy_api_field_config.filter.network.http_connection_manager.v2.HttpConnectionManager.tracing.custom_tags>`.
	//
	// Deprecated: Do not use.
	request_headers_for_tags?: [...string]
	// Target percentage of requests managed by this HTTP connection manager that will be force
	// traced if the :ref:`x-client-trace-id <config_http_conn_man_headers_x-client-trace-id>`
	// header is set. This field is a direct analog for the runtime variable
	// 'tracing.client_sampling' in the :ref:`HTTP Connection Manager
	// <config_http_conn_man_runtime>`.
	// Default: 100%
	client_sampling?: _type.#Percent
	// Target percentage of requests managed by this HTTP connection manager that will be randomly
	// selected for trace generation, if not requested by the client or not forced. This field is
	// a direct analog for the runtime variable 'tracing.random_sampling' in the
	// :ref:`HTTP Connection Manager <config_http_conn_man_runtime>`.
	// Default: 100%
	random_sampling?: _type.#Percent
	// Target percentage of requests managed by this HTTP connection manager that will be traced
	// after all other sampling checks have been applied (client-directed, force tracing, random
	// sampling). This field functions as an upper limit on the total configured sampling rate. For
	// instance, setting client_sampling to 100% but overall_sampling to 1% will result in only 1%
	// of client requests with the appropriate headers to be force traced. This field is a direct
	// analog for the runtime variable 'tracing.global_enabled' in the
	// :ref:`HTTP Connection Manager <config_http_conn_man_runtime>`.
	// Default: 100%
	overall_sampling?: _type.#Percent
	// Whether to annotate spans with additional data. If true, spans will include logs for stream
	// events.
	verbose?: bool
	// Maximum length of the request path to extract and include in the HttpUrl tag. Used to
	// truncate lengthy request paths to meet the needs of a tracing backend.
	// Default: 256
	max_path_tag_length?: uint32
	// A list of custom tags with unique tag name to create tags for the active span.
	custom_tags?: [...v22.#CustomTag]
	// Configuration for an external tracing provider.
	// If not specified, no tracing will be performed.
	//
	// .. attention::
	//   Please be aware that *envoy.tracers.opencensus* provider can only be configured once
	//   in Envoy lifetime.
	//   Any attempts to reconfigure it or to use different configurations for different HCM filters
	//   will be rejected.
	//   Such a constraint is inherent to OpenCensus itself. It cannot be overcome without changes
	//   on OpenCensus side.
	provider?: v23.#Tracing_Http
}

#HttpConnectionManager_InternalAddressConfig: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.HttpConnectionManager_InternalAddressConfig"
	// Whether unix socket addresses should be considered internal.
	unix_sockets?: bool
}

// [#next-free-field: 7]
#HttpConnectionManager_SetCurrentClientCertDetails: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.HttpConnectionManager_SetCurrentClientCertDetails"
	// Whether to forward the subject of the client cert. Defaults to false.
	subject?: bool
	// Whether to forward the entire client cert in URL encoded PEM format. This will appear in the
	// XFCC header comma separated from other values with the value Cert="PEM".
	// Defaults to false.
	cert?: bool
	// Whether to forward the entire client cert chain (including the leaf cert) in URL encoded PEM
	// format. This will appear in the XFCC header comma separated from other values with the value
	// Chain="PEM".
	// Defaults to false.
	chain?: bool
	// Whether to forward the DNS type Subject Alternative Names of the client cert.
	// Defaults to false.
	dns?: bool
	// Whether to forward the URI type Subject Alternative Name of the client cert. Defaults to
	// false.
	uri?: bool
}

// The configuration for HTTP upgrades.
// For each upgrade type desired, an UpgradeConfig must be added.
//
// .. warning::
//
//    The current implementation of upgrade headers does not handle
//    multi-valued upgrade headers. Support for multi-valued headers may be
//    added in the future if needed.
//
// .. warning::
//    The current implementation of upgrade headers does not work with HTTP/2
//    upstreams.
#HttpConnectionManager_UpgradeConfig: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.HttpConnectionManager_UpgradeConfig"
	// The case-insensitive name of this upgrade, e.g. "websocket".
	// For each upgrade type present in upgrade_configs, requests with
	// Upgrade: [upgrade_type]
	// will be proxied upstream.
	upgrade_type?: string
	// If present, this represents the filter chain which will be created for
	// this type of upgrade. If no filters are present, the filter chain for
	// HTTP connections will be used for this upgrade type.
	filters?: [...#HttpFilter]
	// Determines if upgrades are enabled or disabled by default. Defaults to true.
	// This can be overridden on a per-route basis with :ref:`cluster
	// <envoy_api_field_route.RouteAction.upgrade_configs>` as documented in the
	// :ref:`upgrade documentation <arch_overview_upgrades>`.
	enabled?: bool
}

// Specifies the mechanism for constructing "scope keys" based on HTTP request attributes. These
// keys are matched against a set of :ref:`Key<envoy_api_msg_ScopedRouteConfiguration.Key>`
// objects assembled from :ref:`ScopedRouteConfiguration<envoy_api_msg_ScopedRouteConfiguration>`
// messages distributed via SRDS (the Scoped Route Discovery Service) or assigned statically via
// :ref:`scoped_route_configurations_list<envoy_api_field_config.filter.network.http_connection_manager.v2.ScopedRoutes.scoped_route_configurations_list>`.
//
// Upon receiving a request's headers, the Router will build a key using the algorithm specified
// by this message. This key will be used to look up the routing table (i.e., the
// :ref:`RouteConfiguration<envoy_api_msg_RouteConfiguration>`) to use for the request.
#ScopedRoutes_ScopeKeyBuilder: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.ScopedRoutes_ScopeKeyBuilder"
	// The final(built) scope key consists of the ordered union of these fragments, which are compared in order with the
	// fragments of a :ref:`ScopedRouteConfiguration<envoy_api_msg_ScopedRouteConfiguration>`.
	// A missing fragment during comparison will make the key invalid, i.e., the computed key doesn't match any key.
	fragments?: [...#ScopedRoutes_ScopeKeyBuilder_FragmentBuilder]
}

// Specifies the mechanism for constructing key fragments which are composed into scope keys.
#ScopedRoutes_ScopeKeyBuilder_FragmentBuilder: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.ScopedRoutes_ScopeKeyBuilder_FragmentBuilder"
	// Specifies how a header field's value should be extracted.
	header_value_extractor?: #ScopedRoutes_ScopeKeyBuilder_FragmentBuilder_HeaderValueExtractor
}

// Specifies how the value of a header should be extracted.
// The following example maps the structure of a header to the fields in this message.
//
// .. code::
//
//              <0> <1>   <-- index
//    X-Header: a=b;c=d
//    |         || |
//    |         || \----> <element_separator>
//    |         ||
//    |         |\----> <element.separator>
//    |         |
//    |         \----> <element.key>
//    |
//    \----> <name>
//
//    Each 'a=b' key-value pair constitutes an 'element' of the header field.
#ScopedRoutes_ScopeKeyBuilder_FragmentBuilder_HeaderValueExtractor: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.ScopedRoutes_ScopeKeyBuilder_FragmentBuilder_HeaderValueExtractor"
	// The name of the header field to extract the value from.
	//
	// .. note::
	//
	//   If the header appears multiple times only the first value is used.
	name?: string
	// The element separator (e.g., ';' separates 'a;b;c;d').
	// Default: empty string. This causes the entirety of the header field to be extracted.
	// If this field is set to an empty string and 'index' is used in the oneof below, 'index'
	// must be set to 0.
	element_separator?: string
	// Specifies the zero based index of the element to extract.
	// Note Envoy concatenates multiple values of the same header key into a comma separated
	// string, the splitting always happens after the concatenation.
	index?: uint32
	// Specifies the key value pair to extract the value from.
	element?: #ScopedRoutes_ScopeKeyBuilder_FragmentBuilder_HeaderValueExtractor_KvElement
}

// Specifies a header field's key value pair to match on.
#ScopedRoutes_ScopeKeyBuilder_FragmentBuilder_HeaderValueExtractor_KvElement: {
	"@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.ScopedRoutes_ScopeKeyBuilder_FragmentBuilder_HeaderValueExtractor_KvElement"
	// The separator between key and value (e.g., '=' separates 'k=v;...').
	// If an element is an empty string, the element is ignored.
	// If an element contains no separator, the whole element is parsed as key and the
	// fragment value is an empty string.
	// If there are multiple values for a matched key, the first value is returned.
	separator?: string
	// The key to match on.
	key?: string
}
