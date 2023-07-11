package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/accesslog/v3"
	v32 "envoyproxy.io/envoy-cue/spec/config/route/v3"
	v33 "envoyproxy.io/envoy-cue/spec/type/v3"
	v34 "envoyproxy.io/envoy-cue/spec/type/tracing/v3"
	v35 "envoyproxy.io/envoy-cue/spec/config/trace/v3"
	v36 "envoyproxy.io/envoy-cue/spec/type/http/v3"
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

// Determines the action for request that contain %2F, %2f, %5C or %5c sequences in the URI path.
// This operation occurs before URL normalization and the merge slashes transformations if they were enabled.
#HttpConnectionManager_PathWithEscapedSlashesAction: "IMPLEMENTATION_SPECIFIC_DEFAULT" | "KEEP_UNCHANGED" | "REJECT_REQUEST" | "UNESCAPE_AND_REDIRECT" | "UNESCAPE_AND_FORWARD"

HttpConnectionManager_PathWithEscapedSlashesAction_IMPLEMENTATION_SPECIFIC_DEFAULT: "IMPLEMENTATION_SPECIFIC_DEFAULT"
HttpConnectionManager_PathWithEscapedSlashesAction_KEEP_UNCHANGED:                  "KEEP_UNCHANGED"
HttpConnectionManager_PathWithEscapedSlashesAction_REJECT_REQUEST:                  "REJECT_REQUEST"
HttpConnectionManager_PathWithEscapedSlashesAction_UNESCAPE_AND_REDIRECT:           "UNESCAPE_AND_REDIRECT"
HttpConnectionManager_PathWithEscapedSlashesAction_UNESCAPE_AND_FORWARD:            "UNESCAPE_AND_FORWARD"

#HttpConnectionManager_Tracing_OperationName: "INGRESS" | "EGRESS"

HttpConnectionManager_Tracing_OperationName_INGRESS: "INGRESS"
HttpConnectionManager_Tracing_OperationName_EGRESS:  "EGRESS"

// [#next-free-field: 51]
#HttpConnectionManager: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager"
	// Supplies the type of codec that the connection manager should use.
	codec_type?: #HttpConnectionManager_CodecType
	// The human readable prefix to use when emitting statistics for the
	// connection manager. See the :ref:`statistics documentation <config_http_conn_man_stats>` for
	// more information.
	stat_prefix?: string
	// The connection manager’s route table will be dynamically loaded via the RDS API.
	rds?: #Rds
	// The route table for the connection manager is static and is specified in this property.
	route_config?: v32.#RouteConfiguration
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
	// <envoy_v3_api_msg_config.trace.v3.Tracing>`.
	tracing?: #HttpConnectionManager_Tracing
	// Additional settings for HTTP requests handled by the connection manager. These will be
	// applicable to both HTTP1 and HTTP2 requests.
	common_http_protocol_options?: v3.#HttpProtocolOptions
	// Additional HTTP/1 settings that are passed to the HTTP/1 codec.
	// [#comment:TODO: The following fields are ignored when the
	// :ref:`header validation configuration <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.typed_header_validation_config>`
	// is present:
	// 1. :ref:`allow_chunked_length <envoy_v3_api_field_config.core.v3.Http1ProtocolOptions.allow_chunked_length>`]
	http_protocol_options?: v3.#Http1ProtocolOptions
	// Additional HTTP/2 settings that are passed directly to the HTTP/2 codec.
	http2_protocol_options?: v3.#Http2ProtocolOptions
	// Additional HTTP/3 settings that are passed directly to the HTTP/3 codec.
	// [#not-implemented-hide:]
	http3_protocol_options?: v3.#Http3ProtocolOptions
	// An optional override that the connection manager will write to the server
	// header in responses. If not set, the default is ``envoy``.
	server_name?: string
	// Defines the action to be applied to the Server header on the response path.
	// By default, Envoy will overwrite the header with the value specified in
	// server_name.
	server_header_transformation?: #HttpConnectionManager_ServerHeaderTransformation
	// Allows for explicit transformation of the :scheme header on the request path.
	// If not set, Envoy's default :ref:`scheme  <config_http_conn_man_headers_scheme>`
	// handling applies.
	scheme_header_transformation?: v3.#SchemeHeaderTransformation
	// The maximum request headers size for incoming connections.
	// If unconfigured, the default max request headers allowed is 60 KiB.
	// Requests that exceed this limit will receive a 431 response.
	max_request_headers_kb?: uint32
	// The stream idle timeout for connections managed by the connection manager.
	// If not specified, this defaults to 5 minutes. The default value was selected
	// so as not to interfere with any smaller configured timeouts that may have
	// existed in configurations prior to the introduction of this feature, while
	// introducing robustness to TCP connections that terminate without a FIN.
	//
	// This idle timeout applies to new streams and is overridable by the
	// :ref:`route-level idle_timeout
	// <envoy_v3_api_field_config.route.v3.RouteAction.idle_timeout>`. Even on a stream in
	// which the override applies, prior to receipt of the initial request
	// headers, the :ref:`stream_idle_timeout
	// <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.stream_idle_timeout>`
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
	// <envoy_v3_api_field_config.core.v3.HttpProtocolOptions.max_stream_duration>` does not apply to
	// this corner case.
	//
	// If the :ref:`overload action <config_overload_manager_overload_actions>` "envoy.overload_actions.reduce_timeouts"
	// is configured, this timeout is scaled according to the value for
	// :ref:`HTTP_DOWNSTREAM_STREAM_IDLE <envoy_v3_api_enum_value_config.overload.v3.ScaleTimersOverloadActionConfig.TimerType.HTTP_DOWNSTREAM_STREAM_IDLE>`.
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
	// The amount of time that Envoy will wait for the request headers to be received. The timer is
	// activated when the first byte of the headers is received, and is disarmed when the last byte of
	// the headers has been received. If not specified or set to 0, this timeout is disabled.
	request_headers_timeout?: string
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
	access_log?: [...v31.#AccessLog]
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
	// The configuration for the original IP detection extensions.
	//
	// When configured the extensions will be called along with the request headers
	// and information about the downstream connection, such as the directly connected address.
	// Each extension will then use these parameters to decide the request's effective remote address.
	// If an extension fails to detect the original IP address and isn't configured to reject
	// the request, the HCM will try the remaining extensions until one succeeds or rejects
	// the request. If the request isn't rejected nor any extension succeeds, the HCM will
	// fallback to using the remote address.
	//
	// .. WARNING::
	//    Extensions cannot be used in conjunction with :ref:`use_remote_address
	//    <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.use_remote_address>`
	//    nor :ref:`xff_num_trusted_hops
	//    <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.xff_num_trusted_hops>`.
	//
	// [#extension-category: envoy.http.original_ip_detection]
	original_ip_detection_extensions?: [...v3.#TypedExtensionConfig]
	// Configures what network addresses are considered internal for stats and header sanitation
	// purposes. If unspecified, only RFC1918 IP addresses will be considered internal.
	// See the documentation for :ref:`config_http_conn_man_headers_x-envoy-internal` for more
	// information about internal/external addresses.
	internal_address_config?: #HttpConnectionManager_InternalAddressConfig
	// If set, Envoy will not append the remote address to the
	// :ref:`config_http_conn_man_headers_x-forwarded-for` HTTP header. This may be used in
	// conjunction with HTTP filters that explicitly manipulate XFF after the HTTP connection manager
	// has mutated the request headers. While :ref:`use_remote_address
	// <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.use_remote_address>`
	// will also suppress XFF addition, it has consequences for logging and other
	// Envoy uses of the remote address, so ``skip_xff_append`` should be used
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
	// If set, Envoy will always set :ref:`x-request-id <config_http_conn_man_headers_x-request-id>` header in response.
	// If this is false or not set, the request ID is returned in responses only if tracing is forced using
	// :ref:`x-envoy-force-trace <config_http_conn_man_headers_x-envoy-force-trace>` header.
	always_set_request_id_in_response?: bool
	// How to handle the :ref:`config_http_conn_man_headers_x-forwarded-client-cert` (XFCC) HTTP
	// header.
	forward_client_cert_details?: #HttpConnectionManager_ForwardClientCertDetails
	// This field is valid only when :ref:`forward_client_cert_details
	// <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.forward_client_cert_details>`
	// is APPEND_FORWARD or SANITIZE_SET and the client connection is mTLS. It specifies the fields in
	// the client certificate to be forwarded. Note that in the
	// :ref:`config_http_conn_man_headers_x-forwarded-client-cert` header, ``Hash`` is always set, and
	// ``By`` is always set when the client certificate presents the URI type Subject Alternative Name
	// value.
	set_current_client_cert_details?: #HttpConnectionManager_SetCurrentClientCertDetails
	// If proxy_100_continue is true, Envoy will proxy incoming "Expect:
	// 100-continue" headers upstream, and forward "100 Continue" responses
	// downstream. If this is false or not set, Envoy will instead strip the
	// "Expect: 100-continue" header, and send a "100 Continue" response itself.
	proxy_100_continue?: bool
	// If
	// :ref:`use_remote_address
	// <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.use_remote_address>`
	// is true and represent_ipv4_remote_address_as_ipv4_mapped_ipv6 is true and the remote address is
	// an IPv4 address, the address will be mapped to IPv6 before it is appended to ``x-forwarded-for``.
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
	// requests by HTTP filters or routing? This affects the upstream ``:path`` header
	// as well. For paths that fail this check, Envoy will respond with 400 to
	// paths that are malformed. This defaults to false currently but will default
	// true in the future. When not specified, this value may be overridden by the
	// runtime variable
	// :ref:`http_connection_manager.normalize_path<config_http_conn_man_runtime_normalize_path>`.
	// See `Normalization and Comparison <https://tools.ietf.org/html/rfc3986#section-6>`_
	// for details of normalization.
	// Note that Envoy does not perform
	// `case normalization <https://tools.ietf.org/html/rfc3986#section-6.2.2.1>`_
	// [#comment:TODO: This field is ignored when the
	// :ref:`header validation configuration <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.typed_header_validation_config>`
	// is present.]
	normalize_path?: bool
	// Determines if adjacent slashes in the path are merged into one before any processing of
	// requests by HTTP filters or routing. This affects the upstream ``:path`` header as well. Without
	// setting this option, incoming requests with path ``//dir///file`` will not match against route
	// with ``prefix`` match set to ``/dir``. Defaults to ``false``. Note that slash merging is not part of
	// `HTTP spec <https://tools.ietf.org/html/rfc3986>`_ and is provided for convenience.
	// [#comment:TODO: This field is ignored when the
	// :ref:`header validation configuration <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.typed_header_validation_config>`
	// is present.]
	merge_slashes?: bool
	// Action to take when request URL path contains escaped slash sequences (%2F, %2f, %5C and %5c).
	// The default value can be overridden by the :ref:`http_connection_manager.path_with_escaped_slashes_action<config_http_conn_man_runtime_path_with_escaped_slashes_action>`
	// runtime variable.
	// The :ref:`http_connection_manager.path_with_escaped_slashes_action_sampling<config_http_conn_man_runtime_path_with_escaped_slashes_action_enabled>` runtime
	// variable can be used to apply the action to a portion of all requests.
	// [#comment:TODO: This field is ignored when the
	// :ref:`header validation configuration <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.typed_header_validation_config>`
	// is present.]
	path_with_escaped_slashes_action?: #HttpConnectionManager_PathWithEscapedSlashesAction
	// The configuration of the request ID extension. This includes operations such as
	// generation, validation, and associated tracing operations. If empty, the
	// :ref:`UuidRequestIdConfig <envoy_v3_api_msg_extensions.request_id.uuid.v3.UuidRequestIdConfig>`
	// default extension is used with default parameters. See the documentation for that extension
	// for details on what it does. Customizing the configuration for the default extension can be
	// achieved by configuring it explicitly here. For example, to disable trace reason packing,
	// the following configuration can be used:
	//
	// .. validated-code-block:: yaml
	//   :type-name: envoy.extensions.filters.network.http_connection_manager.v3.RequestIDExtension
	//
	//   typed_config:
	//     "@type": type.googleapis.com/envoy.extensions.request_id.uuid.v3.UuidRequestIdConfig
	//     pack_trace_reason: false
	//
	// [#extension-category: envoy.request_id]
	request_id_extension?: #RequestIDExtension
	// The configuration to customize local reply returned by Envoy. It can customize status code,
	// body text and response content type. If not specified, status code and text body are hard
	// coded in Envoy, the response content type is plain text.
	local_reply_config?: #LocalReplyConfig
	// Determines if the port part should be removed from host/authority header before any processing
	// of request by HTTP filters or routing. The port would be removed only if it is equal to the :ref:`listener's<envoy_v3_api_field_config.listener.v3.Listener.address>`
	// local port. This affects the upstream host header unless the method is
	// CONNECT in which case if no filter adds a port the original port will be restored before headers are
	// sent upstream.
	// Without setting this option, incoming requests with host ``example:443`` will not match against
	// route with :ref:`domains<envoy_v3_api_field_config.route.v3.VirtualHost.domains>` match set to ``example``. Defaults to ``false``. Note that port removal is not part
	// of `HTTP spec <https://tools.ietf.org/html/rfc3986>`_ and is provided for convenience.
	// Only one of ``strip_matching_host_port`` or ``strip_any_host_port`` can be set.
	strip_matching_host_port?: bool
	// Determines if the port part should be removed from host/authority header before any processing
	// of request by HTTP filters or routing.
	// This affects the upstream host header unless the method is CONNECT in
	// which case if no filter adds a port the original port will be restored before headers are sent upstream.
	// Without setting this option, incoming requests with host ``example:443`` will not match against
	// route with :ref:`domains<envoy_v3_api_field_config.route.v3.VirtualHost.domains>` match set to ``example``. Defaults to ``false``. Note that port removal is not part
	// of `HTTP spec <https://tools.ietf.org/html/rfc3986>`_ and is provided for convenience.
	// Only one of ``strip_matching_host_port`` or ``strip_any_host_port`` can be set.
	strip_any_host_port?: bool
	// Governs Envoy's behavior when receiving invalid HTTP from downstream.
	// If this option is false (default), Envoy will err on the conservative side handling HTTP
	// errors, terminating both HTTP/1.1 and HTTP/2 connections when receiving an invalid request.
	// If this option is set to true, Envoy will be more permissive, only resetting the invalid
	// stream in the case of HTTP/2 and leaving the connection open where possible (if the entire
	// request is read for HTTP/1.1)
	// In general this should be true for deployments receiving trusted traffic (L2 Envoys,
	// company-internal mesh) and false when receiving untrusted traffic (edge deployments).
	//
	// If different behaviors for invalid_http_message for HTTP/1 and HTTP/2 are
	// desired, one should use the new HTTP/1 option :ref:`override_stream_error_on_invalid_http_message
	// <envoy_v3_api_field_config.core.v3.Http1ProtocolOptions.override_stream_error_on_invalid_http_message>` or the new HTTP/2 option
	// :ref:`override_stream_error_on_invalid_http_message
	// <envoy_v3_api_field_config.core.v3.Http2ProtocolOptions.override_stream_error_on_invalid_http_message>`
	// ``not`` the deprecated but similarly named :ref:`stream_error_on_invalid_http_messaging
	// <envoy_v3_api_field_config.core.v3.Http2ProtocolOptions.stream_error_on_invalid_http_messaging>`
	stream_error_on_invalid_http_message?: bool
	// [#not-implemented-hide:] Path normalization configuration. This includes
	// configurations for transformations (e.g. RFC 3986 normalization or merge
	// adjacent slashes) and the policy to apply them. The policy determines
	// whether transformations affect the forwarded ``:path`` header. RFC 3986 path
	// normalization is enabled by default and the default policy is that the
	// normalized header will be forwarded. See :ref:`PathNormalizationOptions
	// <envoy_v3_api_msg_extensions.filters.network.http_connection_manager.v3.PathNormalizationOptions>`
	// for details.
	path_normalization_options?: #HttpConnectionManager_PathNormalizationOptions
	// Determines if trailing dot of the host should be removed from host/authority header before any
	// processing of request by HTTP filters or routing.
	// This affects the upstream host header.
	// Without setting this option, incoming requests with host ``example.com.`` will not match against
	// route with :ref:`domains<envoy_v3_api_field_config.route.v3.VirtualHost.domains>` match set to ``example.com``. Defaults to ``false``.
	// When the incoming request contains a host/authority header that includes a port number,
	// setting this option will strip a trailing dot, if present, from the host section,
	// leaving the port as is (e.g. host value ``example.com.:443`` will be updated to ``example.com:443``).
	strip_trailing_host_dot?: bool
	// Proxy-Status HTTP response header configuration.
	// If this config is set, the Proxy-Status HTTP response header field is
	// populated. By default, it is not.
	proxy_status_config?: #HttpConnectionManager_ProxyStatusConfig
	// Configuration options for Header Validation (UHV).
	// UHV is an extensible mechanism for checking validity of HTTP requests as well as providing
	// normalization for request attributes, such as URI path.
	// If the typed_header_validation_config is present it overrides the following options:
	// ``normalize_path``, ``merge_slashes``, ``path_with_escaped_slashes_action``
	// ``http_protocol_options.allow_chunked_length``.
	//
	// The default UHV checks the following:
	//
	// #. HTTP/1 header map validity according to `RFC 7230 section 3.2<https://datatracker.ietf.org/doc/html/rfc7230#section-3.2>`_
	// #. Syntax of HTTP/1 request target URI and response status
	// #. HTTP/2 header map validity according to `RFC 7540 section 8.1.2<https://datatracker.ietf.org/doc/html/rfc7540#section-8.1.2`_
	// #. Syntax of HTTP/2 pseudo headers
	// #. HTTP/3 header map validity according to `RFC 9114 section 4.3 <https://www.rfc-editor.org/rfc/rfc9114.html>`_
	// #. Syntax of HTTP/3 pseudo headers
	// #. Syntax of ``Content-Length`` and ``Transfer-Encoding``
	// #. Validation of HTTP/1 requests with both ``Content-Length`` and ``Transfer-Encoding`` headers
	// #. Normalization of the URI path according to `Normalization and Comparison <https://datatracker.ietf.org/doc/html/rfc3986#section-6>`_
	//    without `case normalization <https://datatracker.ietf.org/doc/html/rfc3986#section-6.2.2.1>`_
	//
	// [#not-implemented-hide:]
	// [#extension-category: envoy.http.header_validators]
	typed_header_validation_config?: v3.#TypedExtensionConfig
}

// The configuration to customize local reply returned by Envoy.
#LocalReplyConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.LocalReplyConfig"
	// Configuration of list of mappers which allows to filter and change local response.
	// The mappers will be checked by the specified order until one is matched.
	mappers?: [...#ResponseMapper]
	// The configuration to form response body from the :ref:`command operators <config_access_log_command_operators>`
	// and to specify response content type as one of: plain/text or application/json.
	//
	// Example one: "plain/text" ``body_format``.
	//
	// .. validated-code-block:: yaml
	//   :type-name: envoy.config.core.v3.SubstitutionFormatString
	//
	//   text_format: "%LOCAL_REPLY_BODY%:%RESPONSE_CODE%:path=%REQ(:path)%\n"
	//
	// The following response body in "plain/text" format will be generated for a request with
	// local reply body of "upstream connection error", response_code=503 and path=/foo.
	//
	// .. code-block:: text
	//
	//   upstream connect error:503:path=/foo
	//
	// Example two: "application/json" ``body_format``.
	//
	// .. validated-code-block:: yaml
	//   :type-name: envoy.config.core.v3.SubstitutionFormatString
	//
	//   json_format:
	//     status: "%RESPONSE_CODE%"
	//     message: "%LOCAL_REPLY_BODY%"
	//     path: "%REQ(:path)%"
	//
	// The following response body in "application/json" format would be generated for a request with
	// local reply body of "upstream connection error", response_code=503 and path=/foo.
	//
	// .. code-block:: json
	//
	//  {
	//    "status": 503,
	//    "message": "upstream connection error",
	//    "path": "/foo"
	//  }
	//
	body_format?: v3.#SubstitutionFormatString
}

// The configuration to filter and change local response.
// [#next-free-field: 6]
#ResponseMapper: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.ResponseMapper"
	// Filter to determine if this mapper should apply.
	filter?: v31.#AccessLogFilter
	// The new response status code if specified.
	status_code?: uint32
	// The new local reply body text if specified. It will be used in the ``%LOCAL_REPLY_BODY%``
	// command operator in the ``body_format``.
	body?: v3.#DataSource
	// A per mapper ``body_format`` to override the :ref:`body_format <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.LocalReplyConfig.body_format>`.
	// It will be used when this mapper is matched.
	body_format_override?: v3.#SubstitutionFormatString
	// HTTP headers to add to a local reply. This allows the response mapper to append, to add
	// or to override headers of any local reply before it is sent to a downstream client.
	headers_to_add?: [...v3.#HeaderValueOption]
}

#Rds: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.Rds"
	// Configuration source specifier for RDS.
	config_source?: v3.#ConfigSource
	// The name of the route configuration. This name will be passed to the RDS
	// API. This allows an Envoy configuration with multiple HTTP listeners (and
	// associated HTTP connection manager filters) to use different route
	// configurations.
	route_config_name?: string
}

// This message is used to work around the limitations with 'oneof' and repeated fields.
#ScopedRouteConfigurationsList: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.ScopedRouteConfigurationsList"
	scoped_route_configurations?: [...v32.#ScopedRouteConfiguration]
}

// [#next-free-field: 6]
#ScopedRoutes: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.ScopedRoutes"
	// The name assigned to the scoped routing configuration.
	name?: string
	// The algorithm to use for constructing a scope key for each request.
	scope_key_builder?: #ScopedRoutes_ScopeKeyBuilder
	// Configuration source specifier for RDS.
	// This config source is used to subscribe to RouteConfiguration resources specified in
	// ScopedRouteConfiguration messages.
	rds_config_source?: v3.#ConfigSource
	// The set of routing scopes corresponding to the HCM. A scope is assigned to a request by
	// matching a key constructed from the request's attributes according to the algorithm specified
	// by the
	// :ref:`ScopeKeyBuilder<envoy_v3_api_msg_extensions.filters.network.http_connection_manager.v3.ScopedRoutes.ScopeKeyBuilder>`
	// in this message.
	scoped_route_configurations_list?: #ScopedRouteConfigurationsList
	// The set of routing scopes associated with the HCM will be dynamically loaded via the SRDS
	// API. A scope is assigned to a request by matching a key constructed from the request's
	// attributes according to the algorithm specified by the
	// :ref:`ScopeKeyBuilder<envoy_v3_api_msg_extensions.filters.network.http_connection_manager.v3.ScopedRoutes.ScopeKeyBuilder>`
	// in this message.
	scoped_rds?: #ScopedRds
}

#ScopedRds: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.ScopedRds"
	// Configuration source specifier for scoped RDS.
	scoped_rds_config_source?: v3.#ConfigSource
	// xdstp:// resource locator for scoped RDS collection.
	// [#not-implemented-hide:]
	srds_resources_locator?: string
}

// [#next-free-field: 7]
#HttpFilter: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpFilter"
	// The name of the filter configuration. It also serves as a resource name in ExtensionConfigDS.
	name?: string
	// Filter specific configuration which depends on the filter being instantiated. See the supported
	// filters for further documentation.
	//
	// To support configuring a :ref:`match tree <arch_overview_matching_api>`, use an
	// :ref:`ExtensionWithMatcher <envoy_v3_api_msg_extensions.common.matching.v3.ExtensionWithMatcher>`
	// with the desired HTTP filter.
	// [#extension-category: envoy.filters.http]
	typed_config?: _
	// Configuration source specifier for an extension configuration discovery service.
	// In case of a failure and without the default configuration, the HTTP listener responds with code 500.
	// Extension configs delivered through this mechanism are not expected to require warming (see https://github.com/envoyproxy/envoy/issues/12061).
	//
	// To support configuring a :ref:`match tree <arch_overview_matching_api>`, use an
	// :ref:`ExtensionWithMatcher <envoy_v3_api_msg_extensions.common.matching.v3.ExtensionWithMatcher>`
	// with the desired HTTP filter. This works for both the default filter configuration as well
	// as for filters provided via the API.
	config_discovery?: v3.#ExtensionConfigSource
	// If true, clients that do not support this filter may ignore the
	// filter but otherwise accept the config.
	// Otherwise, clients that do not support this filter must reject the config.
	// This is also same with typed per filter config.
	is_optional?: bool
}

#RequestIDExtension: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.RequestIDExtension"
	// Request ID extension specific configuration.
	typed_config?: _
}

// [#protodoc-title: Envoy Mobile HTTP connection manager]
// HTTP connection manager for use in Envoy mobile.
// [#extension: envoy.filters.network.envoy_mobile_http_connection_manager]
#EnvoyMobileHttpConnectionManager: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.EnvoyMobileHttpConnectionManager"
	// The configuration for the underlying HttpConnectionManager which will be
	// instantiated for Envoy mobile.
	config?: #HttpConnectionManager
}

// [#next-free-field: 10]
#HttpConnectionManager_Tracing: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager_Tracing"
	// Target percentage of requests managed by this HTTP connection manager that will be force
	// traced if the :ref:`x-client-trace-id <config_http_conn_man_headers_x-client-trace-id>`
	// header is set. This field is a direct analog for the runtime variable
	// 'tracing.client_sampling' in the :ref:`HTTP Connection Manager
	// <config_http_conn_man_runtime>`.
	// Default: 100%
	client_sampling?: v33.#Percent
	// Target percentage of requests managed by this HTTP connection manager that will be randomly
	// selected for trace generation, if not requested by the client or not forced. This field is
	// a direct analog for the runtime variable 'tracing.random_sampling' in the
	// :ref:`HTTP Connection Manager <config_http_conn_man_runtime>`.
	// Default: 100%
	random_sampling?: v33.#Percent
	// Target percentage of requests managed by this HTTP connection manager that will be traced
	// after all other sampling checks have been applied (client-directed, force tracing, random
	// sampling). This field functions as an upper limit on the total configured sampling rate. For
	// instance, setting client_sampling to 100% but overall_sampling to 1% will result in only 1%
	// of client requests with the appropriate headers to be force traced. This field is a direct
	// analog for the runtime variable 'tracing.global_enabled' in the
	// :ref:`HTTP Connection Manager <config_http_conn_man_runtime>`.
	// Default: 100%
	overall_sampling?: v33.#Percent
	// Whether to annotate spans with additional data. If true, spans will include logs for stream
	// events.
	verbose?: bool
	// Maximum length of the request path to extract and include in the HttpUrl tag. Used to
	// truncate lengthy request paths to meet the needs of a tracing backend.
	// Default: 256
	max_path_tag_length?: uint32
	// A list of custom tags with unique tag name to create tags for the active span.
	custom_tags?: [...v34.#CustomTag]
	// Configuration for an external tracing provider.
	// If not specified, no tracing will be performed.
	//
	// .. attention::
	//   Please be aware that ``envoy.tracers.opencensus`` provider can only be configured once
	//   in Envoy lifetime.
	//   Any attempts to reconfigure it or to use different configurations for different HCM filters
	//   will be rejected.
	//   Such a constraint is inherent to OpenCensus itself. It cannot be overcome without changes
	//   on OpenCensus side.
	provider?: v35.#Tracing_Http
}

#HttpConnectionManager_InternalAddressConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager_InternalAddressConfig"
	// Whether unix socket addresses should be considered internal.
	unix_sockets?: bool
	// List of CIDR ranges that are treated as internal. If unset, then RFC1918 / RFC4193
	// IP addresses will be considered internal.
	cidr_ranges?: [...v3.#CidrRange]
}

// [#next-free-field: 7]
#HttpConnectionManager_SetCurrentClientCertDetails: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager_SetCurrentClientCertDetails"
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
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager_UpgradeConfig"
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
	// <envoy_v3_api_field_config.route.v3.RouteAction.upgrade_configs>` as documented in the
	// :ref:`upgrade documentation <arch_overview_upgrades>`.
	enabled?: bool
}

// [#not-implemented-hide:] Transformations that apply to path headers. Transformations are applied
// before any processing of requests by HTTP filters, routing, and matching. Only the normalized
// path will be visible internally if a transformation is enabled. Any path rewrites that the
// router performs (e.g. :ref:`regex_rewrite
// <envoy_v3_api_field_config.route.v3.RouteAction.regex_rewrite>` or :ref:`prefix_rewrite
// <envoy_v3_api_field_config.route.v3.RouteAction.prefix_rewrite>`) will apply to the ``:path`` header
// destined for the upstream.
//
// Note: access logging and tracing will show the original ``:path`` header.
#HttpConnectionManager_PathNormalizationOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager_PathNormalizationOptions"
	// [#not-implemented-hide:] Normalization applies internally before any processing of requests by
	// HTTP filters, routing, and matching *and* will affect the forwarded ``:path`` header. Defaults
	// to :ref:`NormalizePathRFC3986
	// <envoy_v3_api_msg_type.http.v3.PathTransformation.Operation.NormalizePathRFC3986>`. When not
	// specified, this value may be overridden by the runtime variable
	// :ref:`http_connection_manager.normalize_path<config_http_conn_man_runtime_normalize_path>`.
	// Envoy will respond with 400 to paths that are malformed (e.g. for paths that fail RFC 3986
	// normalization due to disallowed characters.)
	forwarding_transformation?: v36.#PathTransformation
	// [#not-implemented-hide:] Normalization only applies internally before any processing of
	// requests by HTTP filters, routing, and matching. These will be applied after full
	// transformation is applied. The ``:path`` header before this transformation will be restored in
	// the router filter and sent upstream unless it was mutated by a filter. Defaults to no
	// transformations.
	// Multiple actions can be applied in the same Transformation, forming a sequential
	// pipeline. The transformations will be performed in the order that they appear. Envoy will
	// respond with 400 to paths that are malformed (e.g. for paths that fail RFC 3986
	// normalization due to disallowed characters.)
	http_filter_transformation?: v36.#PathTransformation
}

// Configures the manner in which the Proxy-Status HTTP response header is
// populated.
//
// See the [Proxy-Status
// RFC](https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-proxy-status-08).
// [#comment:TODO: Update this with the non-draft URL when finalized.]
//
// The Proxy-Status header is a string of the form:
//
//   "<server_name>; error=<error_type>; details=<details>"
// [#next-free-field: 7]
#HttpConnectionManager_ProxyStatusConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager_ProxyStatusConfig"
	// If true, the details field of the Proxy-Status header is not populated with stream_info.response_code_details.
	// This value defaults to ``false``, i.e. the ``details`` field is populated by default.
	remove_details?: bool
	// If true, the details field of the Proxy-Status header will not contain
	// connection termination details. This value defaults to ``false``, i.e. the
	// ``details`` field will contain connection termination details by default.
	remove_connection_termination_details?: bool
	// If true, the details field of the Proxy-Status header will not contain an
	// enumeration of the Envoy ResponseFlags. This value defaults to ``false``,
	// i.e. the ``details`` field will contain a list of ResponseFlags by default.
	remove_response_flags?: bool
	// If true, overwrites the existing Status header with the response code
	// recommended by the Proxy-Status spec.
	// This value defaults to ``false``, i.e. the HTTP response code is not
	// overwritten.
	set_recommended_response_code?: bool
	// If ``use_node_id`` is set, Proxy-Status headers will use the Envoy's node
	// ID as the name of the proxy.
	use_node_id?: bool
	// If ``literal_proxy_name`` is set, Proxy-Status headers will use this
	// value as the name of the proxy.
	literal_proxy_name?: string
}

// Specifies the mechanism for constructing "scope keys" based on HTTP request attributes. These
// keys are matched against a set of :ref:`Key<envoy_v3_api_msg_config.route.v3.ScopedRouteConfiguration.Key>`
// objects assembled from :ref:`ScopedRouteConfiguration<envoy_v3_api_msg_config.route.v3.ScopedRouteConfiguration>`
// messages distributed via SRDS (the Scoped Route Discovery Service) or assigned statically via
// :ref:`scoped_route_configurations_list<envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.ScopedRoutes.scoped_route_configurations_list>`.
//
// Upon receiving a request's headers, the Router will build a key using the algorithm specified
// by this message. This key will be used to look up the routing table (i.e., the
// :ref:`RouteConfiguration<envoy_v3_api_msg_config.route.v3.RouteConfiguration>`) to use for the request.
#ScopedRoutes_ScopeKeyBuilder: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.ScopedRoutes_ScopeKeyBuilder"
	// The final(built) scope key consists of the ordered union of these fragments, which are compared in order with the
	// fragments of a :ref:`ScopedRouteConfiguration<envoy_v3_api_msg_config.route.v3.ScopedRouteConfiguration>`.
	// A missing fragment during comparison will make the key invalid, i.e., the computed key doesn't match any key.
	fragments?: [...#ScopedRoutes_ScopeKeyBuilder_FragmentBuilder]
}

// Specifies the mechanism for constructing key fragments which are composed into scope keys.
#ScopedRoutes_ScopeKeyBuilder_FragmentBuilder: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.ScopedRoutes_ScopeKeyBuilder_FragmentBuilder"
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
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.ScopedRoutes_ScopeKeyBuilder_FragmentBuilder_HeaderValueExtractor"
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
	"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.ScopedRoutes_ScopeKeyBuilder_FragmentBuilder_HeaderValueExtractor_KvElement"
	// The separator between key and value (e.g., '=' separates 'k=v;...').
	// If an element is an empty string, the element is ignored.
	// If an element contains no separator, the whole element is parsed as key and the
	// fragment value is an empty string.
	// If there are multiple values for a matched key, the first value is returned.
	separator?: string
	// The key to match on.
	key?: string
}
