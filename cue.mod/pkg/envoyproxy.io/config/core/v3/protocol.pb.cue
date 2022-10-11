package v3

import (
	v3 "envoyproxy.io/type/v3"
)

// Action to take when Envoy receives client request with header names containing underscore
// characters.
// Underscore character is allowed in header names by the RFC-7230 and this behavior is implemented
// as a security measure due to systems that treat '_' and '-' as interchangeable. Envoy by default allows client request headers with underscore
// characters.
#HttpProtocolOptions_HeadersWithUnderscoresAction: "ALLOW" | "REJECT_REQUEST" | "DROP_HEADER"

HttpProtocolOptions_HeadersWithUnderscoresAction_ALLOW:          "ALLOW"
HttpProtocolOptions_HeadersWithUnderscoresAction_REJECT_REQUEST: "REJECT_REQUEST"
HttpProtocolOptions_HeadersWithUnderscoresAction_DROP_HEADER:    "DROP_HEADER"

// [#not-implemented-hide:]
#TcpProtocolOptions: {
	"@type": "type.googleapis.com/envoy.config.core.v3.TcpProtocolOptions"
}

// Config for keepalive probes in a QUIC connection.
// Note that QUIC keep-alive probing packets work differently from HTTP/2 keep-alive PINGs in a sense that the probing packet
// itself doesn't timeout waiting for a probing response. Quic has a shorter idle timeout than TCP, so it doesn't rely on such probing to discover dead connections. If the peer fails to respond, the connection will idle timeout eventually. Thus, they are configured differently from :ref:`connection_keepalive <envoy_v3_api_field_config.core.v3.Http2ProtocolOptions.connection_keepalive>`.
#QuicKeepAliveSettings: {
	"@type": "type.googleapis.com/envoy.config.core.v3.QuicKeepAliveSettings"
	// The max interval for a connection to send keep-alive probing packets (with PING or PATH_RESPONSE). The value should be smaller than :ref:`connection idle_timeout <envoy_v3_api_field_config.listener.v3.QuicProtocolOptions.idle_timeout>` to prevent idle timeout while not less than 1s to avoid throttling the connection or flooding the peer with probes.
	//
	// If :ref:`initial_interval <envoy_v3_api_field_config.core.v3.QuicKeepAliveSettings.initial_interval>` is absent or zero, a client connection will use this value to start probing.
	//
	// If zero, disable keepalive probing.
	// If absent, use the QUICHE default interval to probe.
	max_interval?: string
	// The interval to send the first few keep-alive probing packets to prevent connection from hitting the idle timeout. Subsequent probes will be sent, each one with an interval exponentially longer than previous one, till it reaches :ref:`max_interval <envoy_v3_api_field_config.core.v3.QuicKeepAliveSettings.max_interval>`. And the probes afterwards will always use :ref:`max_interval <envoy_v3_api_field_config.core.v3.QuicKeepAliveSettings.max_interval>`.
	//
	// The value should be smaller than :ref:`connection idle_timeout <envoy_v3_api_field_config.listener.v3.QuicProtocolOptions.idle_timeout>` to prevent idle timeout and smaller than max_interval to take effect.
	//
	// If absent or zero, disable keepalive probing for a server connection. For a client connection, if :ref:`max_interval <envoy_v3_api_field_config.core.v3.QuicKeepAliveSettings.max_interval>`  is also zero, do not keepalive, otherwise use max_interval or QUICHE default to probe all the time.
	initial_interval?: string
}

// QUIC protocol options which apply to both downstream and upstream connections.
// [#next-free-field: 6]
#QuicProtocolOptions: {
	"@type": "type.googleapis.com/envoy.config.core.v3.QuicProtocolOptions"
	// Maximum number of streams that the client can negotiate per connection. 100
	// if not specified.
	max_concurrent_streams?: uint32
	// `Initial stream-level flow-control receive window
	// <https://tools.ietf.org/html/draft-ietf-quic-transport-34#section-4.1>`_ size. Valid values range from
	// 1 to 16777216 (2^24, maximum supported by QUICHE) and defaults to 65536 (2^16).
	//
	// NOTE: 16384 (2^14) is the minimum window size supported in Google QUIC. If configured smaller than it, we will use 16384 instead.
	// QUICHE IETF Quic implementation supports 1 bytes window. We only support increasing the default window size now, so it's also the minimum.
	//
	// This field also acts as a soft limit on the number of bytes Envoy will buffer per-stream in the
	// QUIC stream send and receive buffers. Once the buffer reaches this pointer, watermark callbacks will fire to
	// stop the flow of data to the stream buffers.
	initial_stream_window_size?: uint32
	// Similar to ``initial_stream_window_size``, but for connection-level
	// flow-control. Valid values rage from 1 to 25165824 (24MB, maximum supported by QUICHE) and defaults to 65536 (2^16).
	// window. Currently, this has the same minimum/default as ``initial_stream_window_size``.
	//
	// NOTE: 16384 (2^14) is the minimum window size supported in Google QUIC. We only support increasing the default
	// window size now, so it's also the minimum.
	initial_connection_window_size?: uint32
	// The number of timeouts that can occur before port migration is triggered for QUIC clients.
	// This defaults to 1. If set to 0, port migration will not occur on path degrading.
	// Timeout here refers to QUIC internal path degrading timeout mechanism, such as PTO.
	// This has no effect on server sessions.
	num_timeouts_to_trigger_port_migration?: uint32
	// Probes the peer at the configured interval to solicit traffic, i.e. ACK or PATH_RESPONSE, from the peer to push back connection idle timeout.
	// If absent, use the default keepalive behavior of which a client connection sends PINGs every 15s, and a server connection doesn't do anything.
	connection_keepalive?: #QuicKeepAliveSettings
}

#UpstreamHttpProtocolOptions: {
	"@type": "type.googleapis.com/envoy.config.core.v3.UpstreamHttpProtocolOptions"
	// Set transport socket `SNI <https://en.wikipedia.org/wiki/Server_Name_Indication>`_ for new
	// upstream connections based on the downstream HTTP host/authority header or any other arbitrary
	// header when :ref:`override_auto_sni_header <envoy_v3_api_field_config.core.v3.UpstreamHttpProtocolOptions.override_auto_sni_header>`
	// is set, as seen by the :ref:`router filter <config_http_filters_router>`.
	auto_sni?: bool
	// Automatic validate upstream presented certificate for new upstream connections based on the
	// downstream HTTP host/authority header or any other arbitrary header when :ref:`override_auto_sni_header <envoy_v3_api_field_config.core.v3.UpstreamHttpProtocolOptions.override_auto_sni_header>`
	// is set, as seen by the :ref:`router filter <config_http_filters_router>`.
	// This field is intended to be set with ``auto_sni`` field.
	auto_san_validation?: bool
	// An optional alternative to the host/authority header to be used for setting the SNI value.
	// It should be a valid downstream HTTP header, as seen by the
	// :ref:`router filter <config_http_filters_router>`.
	// If unset, host/authority header will be used for populating the SNI. If the specified header
	// is not found or the value is empty, host/authority header will be used instead.
	// This field is intended to be set with ``auto_sni`` and/or ``auto_san_validation`` fields.
	// If none of these fields are set then setting this would be a no-op.
	override_auto_sni_header?: string
}

// Configures the alternate protocols cache which tracks alternate protocols that can be used to
// make an HTTP connection to an origin server. See https://tools.ietf.org/html/rfc7838 for
// HTTP Alternative Services and https://datatracker.ietf.org/doc/html/draft-ietf-dnsop-svcb-https-04
// for the "HTTPS" DNS resource record.
// [#next-free-field: 6]
#AlternateProtocolsCacheOptions: {
	"@type": "type.googleapis.com/envoy.config.core.v3.AlternateProtocolsCacheOptions"
	// The name of the cache. Multiple named caches allow independent alternate protocols cache
	// configurations to operate within a single Envoy process using different configurations. All
	// alternate protocols cache options with the same name *must* be equal in all fields when
	// referenced from different configuration components. Configuration will fail to load if this is
	// not the case.
	name?: string
	// The maximum number of entries that the cache will hold. If not specified defaults to 1024.
	//
	// .. note:
	//
	//   The implementation is approximate and enforced independently on each worker thread, thus
	//   it is possible for the maximum entries in the cache to go slightly above the configured
	//   value depending on timing. This is similar to how other circuit breakers work.
	max_entries?: uint32
	// Allows configuring a persistent
	// :ref:`key value store <envoy_v3_api_msg_config.common.key_value.v3.KeyValueStoreConfig>` to flush
	// alternate protocols entries to disk.
	// This function is currently only supported if concurrency is 1
	// Cached entries will take precedence over pre-populated entries below.
	key_value_store_config?: #TypedExtensionConfig
	// Allows pre-populating the cache with entries, as described above.
	prepopulated_entries?: [...#AlternateProtocolsCacheOptions_AlternateProtocolsCacheEntry]
	// Optional list of hostnames suffixes for which Alt-Svc entries can be shared. For example, if
	// this list contained the value ``.c.example.com``, then an Alt-Svc entry for ``foo.c.example.com``
	// could be shared with ``bar.c.example.com`` but would not be shared with ``baz.example.com``. On
	// the other hand, if the list contained the value ``.example.com`` then all three hosts could share
	// Alt-Svc entries. Each entry must start with ``.``.  If a hostname matches multiple suffixes, the
	// first listed suffix will be used.
	//
	// Since lookup in this list is O(n), it is recommended that the number of suffixes be limited.
	// [#not-implemented-hide:]
	canonical_suffixes?: [...string]
}

// [#next-free-field: 7]
#HttpProtocolOptions: {
	"@type": "type.googleapis.com/envoy.config.core.v3.HttpProtocolOptions"
	// The idle timeout for connections. The idle timeout is defined as the
	// period in which there are no active requests. When the
	// idle timeout is reached the connection will be closed. If the connection is an HTTP/2
	// downstream connection a drain sequence will occur prior to closing the connection, see
	// :ref:`drain_timeout
	// <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.drain_timeout>`.
	// Note that request based timeouts mean that HTTP/2 PINGs will not keep the connection alive.
	// If not specified, this defaults to 1 hour. To disable idle timeouts explicitly set this to 0.
	//
	// .. warning::
	//   Disabling this timeout has a highly likelihood of yielding connection leaks due to lost TCP
	//   FIN packets, etc.
	//
	// If the :ref:`overload action <config_overload_manager_overload_actions>` "envoy.overload_actions.reduce_timeouts"
	// is configured, this timeout is scaled for downstream connections according to the value for
	// :ref:`HTTP_DOWNSTREAM_CONNECTION_IDLE <envoy_v3_api_enum_value_config.overload.v3.ScaleTimersOverloadActionConfig.TimerType.HTTP_DOWNSTREAM_CONNECTION_IDLE>`.
	idle_timeout?: string
	// The maximum duration of a connection. The duration is defined as a period since a connection
	// was established. If not set, there is no max duration. When max_connection_duration is reached
	// and if there are no active streams, the connection will be closed. If the connection is a
	// downstream connection and there are any active streams, the drain sequence will kick-in,
	// and the connection will be force-closed after the drain period. See :ref:`drain_timeout
	// <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.drain_timeout>`.
	max_connection_duration?: string
	// The maximum number of headers. If unconfigured, the default
	// maximum number of request headers allowed is 100. Requests that exceed this limit will receive
	// a 431 response for HTTP/1.x and cause a stream reset for HTTP/2.
	max_headers_count?: uint32
	// Total duration to keep alive an HTTP request/response stream. If the time limit is reached the stream will be
	// reset independent of any other timeouts. If not specified, this value is not set.
	max_stream_duration?: string
	// Action to take when a client request with a header name containing underscore characters is received.
	// If this setting is not specified, the value defaults to ALLOW.
	// Note: upstream responses are not affected by this setting.
	// Note: this only affects client headers. It does not affect headers added
	// by Envoy filters and does not have any impact if added to cluster config.
	headers_with_underscores_action?: #HttpProtocolOptions_HeadersWithUnderscoresAction
	// Optional maximum requests for both upstream and downstream connections.
	// If not specified, there is no limit.
	// Setting this parameter to 1 will effectively disable keep alive.
	// For HTTP/2 and HTTP/3, due to concurrent stream processing, the limit is approximate.
	max_requests_per_connection?: uint32
}

// [#next-free-field: 9]
#Http1ProtocolOptions: {
	"@type": "type.googleapis.com/envoy.config.core.v3.Http1ProtocolOptions"
	// Handle HTTP requests with absolute URLs in the requests. These requests
	// are generally sent by clients to forward/explicit proxies. This allows clients to configure
	// envoy as their HTTP proxy. In Unix, for example, this is typically done by setting the
	// ``http_proxy`` environment variable.
	allow_absolute_url?: bool
	// Handle incoming HTTP/1.0 and HTTP 0.9 requests.
	// This is off by default, and not fully standards compliant. There is support for pre-HTTP/1.1
	// style connect logic, dechunking, and handling lack of client host iff
	// ``default_host_for_http_10`` is configured.
	accept_http_10?: bool
	// A default host for HTTP/1.0 requests. This is highly suggested if ``accept_http_10`` is true as
	// Envoy does not otherwise support HTTP/1.0 without a Host header.
	// This is a no-op if ``accept_http_10`` is not true.
	default_host_for_http_10?: string
	// Describes how the keys for response headers should be formatted. By default, all header keys
	// are lower cased.
	header_key_format?: #Http1ProtocolOptions_HeaderKeyFormat
	// Enables trailers for HTTP/1. By default the HTTP/1 codec drops proxied trailers.
	//
	// .. attention::
	//
	//   Note that this only happens when Envoy is chunk encoding which occurs when:
	//   - The request is HTTP/1.1.
	//   - Is neither a HEAD only request nor a HTTP Upgrade.
	//   - Not a response to a HEAD request.
	//   - The content length header is not present.
	enable_trailers?: bool
	// Allows Envoy to process requests/responses with both ``Content-Length`` and ``Transfer-Encoding``
	// headers set. By default such messages are rejected, but if option is enabled - Envoy will
	// remove Content-Length header and process message.
	// See `RFC7230, sec. 3.3.3 <https://tools.ietf.org/html/rfc7230#section-3.3.3>`_ for details.
	//
	// .. attention::
	//   Enabling this option might lead to request smuggling vulnerability, especially if traffic
	//   is proxied via multiple layers of proxies.
	// [#comment:TODO: This field is ignored when the
	// :ref:`header validation configuration <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.typed_header_validation_config>`
	// is present.]
	allow_chunked_length?: bool
	// Allows invalid HTTP messaging. When this option is false, then Envoy will terminate
	// HTTP/1.1 connections upon receiving an invalid HTTP message. However,
	// when this option is true, then Envoy will leave the HTTP/1.1 connection
	// open where possible.
	// If set, this overrides any HCM :ref:`stream_error_on_invalid_http_messaging
	// <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.stream_error_on_invalid_http_message>`.
	override_stream_error_on_invalid_http_message?: bool
	// Allows sending fully qualified URLs when proxying the first line of the
	// response. By default, Envoy will only send the path components in the first line.
	// If this is true, Envoy will create a fully qualified URI composing scheme
	// (inferred if not present), host (from the host/:authority header) and path
	// (from first line or :path header).
	send_fully_qualified_url?: bool
}

#KeepaliveSettings: {
	"@type": "type.googleapis.com/envoy.config.core.v3.KeepaliveSettings"
	// Send HTTP/2 PING frames at this period, in order to test that the connection is still alive.
	// If this is zero, interval PINGs will not be sent.
	interval?: string
	// How long to wait for a response to a keepalive PING. If a response is not received within this
	// time period, the connection will be aborted. Note that in order to prevent the influence of
	// Head-of-line (HOL) blocking the timeout period is extended when *any* frame is received on
	// the connection, under the assumption that if a frame is received the connection is healthy.
	timeout?: string
	// A random jitter amount as a percentage of interval that will be added to each interval.
	// A value of zero means there will be no jitter.
	// The default value is 15%.
	interval_jitter?: v3.#Percent
	// If the connection has been idle for this duration, send a HTTP/2 ping ahead
	// of new stream creation, to quickly detect dead connections.
	// If this is zero, this type of PING will not be sent.
	// If an interval ping is outstanding, a second ping will not be sent as the
	// interval ping will determine if the connection is dead.
	//
	// The same feature for HTTP/3 is given by inheritance from QUICHE which uses :ref:`connection idle_timeout <envoy_v3_api_field_config.listener.v3.QuicProtocolOptions.idle_timeout>` and the current PTO of the connection to decide whether to probe before sending a new request.
	connection_idle_interval?: string
}

// [#next-free-field: 16]
#Http2ProtocolOptions: {
	"@type": "type.googleapis.com/envoy.config.core.v3.Http2ProtocolOptions"
	// `Maximum table size <https://httpwg.org/specs/rfc7541.html#rfc.section.4.2>`_
	// (in octets) that the encoder is permitted to use for the dynamic HPACK table. Valid values
	// range from 0 to 4294967295 (2^32 - 1) and defaults to 4096. 0 effectively disables header
	// compression.
	hpack_table_size?: uint32
	// `Maximum concurrent streams <https://httpwg.org/specs/rfc7540.html#rfc.section.5.1.2>`_
	// allowed for peer on one HTTP/2 connection. Valid values range from 1 to 2147483647 (2^31 - 1)
	// and defaults to 2147483647.
	//
	// For upstream connections, this also limits how many streams Envoy will initiate concurrently
	// on a single connection. If the limit is reached, Envoy may queue requests or establish
	// additional connections (as allowed per circuit breaker limits).
	//
	// This acts as an upper bound: Envoy will lower the max concurrent streams allowed on a given
	// connection based on upstream settings. Config dumps will reflect the configured upper bound,
	// not the per-connection negotiated limits.
	max_concurrent_streams?: uint32
	// `Initial stream-level flow-control window
	// <https://httpwg.org/specs/rfc7540.html#rfc.section.6.9.2>`_ size. Valid values range from 65535
	// (2^16 - 1, HTTP/2 default) to 2147483647 (2^31 - 1, HTTP/2 maximum) and defaults to 268435456
	// (256 * 1024 * 1024).
	//
	// NOTE: 65535 is the initial window size from HTTP/2 spec. We only support increasing the default
	// window size now, so it's also the minimum.
	//
	// This field also acts as a soft limit on the number of bytes Envoy will buffer per-stream in the
	// HTTP/2 codec buffers. Once the buffer reaches this pointer, watermark callbacks will fire to
	// stop the flow of data to the codec buffers.
	initial_stream_window_size?: uint32
	// Similar to ``initial_stream_window_size``, but for connection-level flow-control
	// window. Currently, this has the same minimum/maximum/default as ``initial_stream_window_size``.
	initial_connection_window_size?: uint32
	// Allows proxying Websocket and other upgrades over H2 connect.
	allow_connect?: bool
	// [#not-implemented-hide:] Hiding until envoy has full metadata support.
	// Still under implementation. DO NOT USE.
	//
	// Allows metadata. See [metadata
	// docs](https://github.com/envoyproxy/envoy/blob/main/source/docs/h2_metadata.md) for more
	// information.
	allow_metadata?: bool
	// Limit the number of pending outbound downstream frames of all types (frames that are waiting to
	// be written into the socket). Exceeding this limit triggers flood mitigation and connection is
	// terminated. The ``http2.outbound_flood`` stat tracks the number of terminated connections due
	// to flood mitigation. The default limit is 10000.
	max_outbound_frames?: uint32
	// Limit the number of pending outbound downstream frames of types PING, SETTINGS and RST_STREAM,
	// preventing high memory utilization when receiving continuous stream of these frames. Exceeding
	// this limit triggers flood mitigation and connection is terminated. The
	// ``http2.outbound_control_flood`` stat tracks the number of terminated connections due to flood
	// mitigation. The default limit is 1000.
	max_outbound_control_frames?: uint32
	// Limit the number of consecutive inbound frames of types HEADERS, CONTINUATION and DATA with an
	// empty payload and no end stream flag. Those frames have no legitimate use and are abusive, but
	// might be a result of a broken HTTP/2 implementation. The `http2.inbound_empty_frames_flood``
	// stat tracks the number of connections terminated due to flood mitigation.
	// Setting this to 0 will terminate connection upon receiving first frame with an empty payload
	// and no end stream flag. The default limit is 1.
	max_consecutive_inbound_frames_with_empty_payload?: uint32
	// Limit the number of inbound PRIORITY frames allowed per each opened stream. If the number
	// of PRIORITY frames received over the lifetime of connection exceeds the value calculated
	// using this formula::
	//
	//   ``max_inbound_priority_frames_per_stream`` * (1 + ``opened_streams``)
	//
	// the connection is terminated. For downstream connections the ``opened_streams`` is incremented when
	// Envoy receives complete response headers from the upstream server. For upstream connection the
	// ``opened_streams`` is incremented when Envoy send the HEADERS frame for a new stream. The
	// ``http2.inbound_priority_frames_flood`` stat tracks
	// the number of connections terminated due to flood mitigation. The default limit is 100.
	max_inbound_priority_frames_per_stream?: uint32
	// Limit the number of inbound WINDOW_UPDATE frames allowed per DATA frame sent. If the number
	// of WINDOW_UPDATE frames received over the lifetime of connection exceeds the value calculated
	// using this formula::
	//
	//   5 + 2 * (``opened_streams`` +
	//            ``max_inbound_window_update_frames_per_data_frame_sent`` * ``outbound_data_frames``)
	//
	// the connection is terminated. For downstream connections the ``opened_streams`` is incremented when
	// Envoy receives complete response headers from the upstream server. For upstream connections the
	// ``opened_streams`` is incremented when Envoy sends the HEADERS frame for a new stream. The
	// ``http2.inbound_priority_frames_flood`` stat tracks the number of connections terminated due to
	// flood mitigation. The default max_inbound_window_update_frames_per_data_frame_sent value is 10.
	// Setting this to 1 should be enough to support HTTP/2 implementations with basic flow control,
	// but more complex implementations that try to estimate available bandwidth require at least 2.
	max_inbound_window_update_frames_per_data_frame_sent?: uint32
	// Allows invalid HTTP messaging and headers. When this option is disabled (default), then
	// the whole HTTP/2 connection is terminated upon receiving invalid HEADERS frame. However,
	// when this option is enabled, only the offending stream is terminated.
	//
	// This is overridden by HCM :ref:`stream_error_on_invalid_http_messaging
	// <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.stream_error_on_invalid_http_message>`
	// iff present.
	//
	// This is deprecated in favor of :ref:`override_stream_error_on_invalid_http_message
	// <envoy_v3_api_field_config.core.v3.Http2ProtocolOptions.override_stream_error_on_invalid_http_message>`
	//
	// See `RFC7540, sec. 8.1 <https://tools.ietf.org/html/rfc7540#section-8.1>`_ for details.
	//
	// Deprecated: Do not use.
	stream_error_on_invalid_http_messaging?: bool
	// Allows invalid HTTP messaging and headers. When this option is disabled (default), then
	// the whole HTTP/2 connection is terminated upon receiving invalid HEADERS frame. However,
	// when this option is enabled, only the offending stream is terminated.
	//
	// This overrides any HCM :ref:`stream_error_on_invalid_http_messaging
	// <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.stream_error_on_invalid_http_message>`
	//
	// See `RFC7540, sec. 8.1 <https://tools.ietf.org/html/rfc7540#section-8.1>`_ for details.
	override_stream_error_on_invalid_http_message?: bool
	// [#not-implemented-hide:]
	// Specifies SETTINGS frame parameters to be sent to the peer, with two exceptions:
	//
	// 1. SETTINGS_ENABLE_PUSH (0x2) is not configurable as HTTP/2 server push is not supported by
	// Envoy.
	//
	// 2. SETTINGS_ENABLE_CONNECT_PROTOCOL (0x8) is only configurable through the named field
	// 'allow_connect'.
	//
	// Note that custom parameters specified through this field can not also be set in the
	// corresponding named parameters:
	//
	// .. code-block:: text
	//
	//   ID    Field Name
	//   ----------------
	//   0x1   hpack_table_size
	//   0x3   max_concurrent_streams
	//   0x4   initial_stream_window_size
	//
	// Collisions will trigger config validation failure on load/update. Likewise, inconsistencies
	// between custom parameters with the same identifier will trigger a failure.
	//
	// See `IANA HTTP/2 Settings
	// <https://www.iana.org/assignments/http2-parameters/http2-parameters.xhtml#settings>`_ for
	// standardized identifiers.
	custom_settings_parameters?: [...#Http2ProtocolOptions_SettingsParameter]
	// Send HTTP/2 PING frames to verify that the connection is still healthy. If the remote peer
	// does not respond within the configured timeout, the connection will be aborted.
	connection_keepalive?: #KeepaliveSettings
}

// [#not-implemented-hide:]
#GrpcProtocolOptions: {
	"@type":                 "type.googleapis.com/envoy.config.core.v3.GrpcProtocolOptions"
	http2_protocol_options?: #Http2ProtocolOptions
}

// A message which allows using HTTP/3.
// [#next-free-field: 6]
#Http3ProtocolOptions: {
	"@type":                "type.googleapis.com/envoy.config.core.v3.Http3ProtocolOptions"
	quic_protocol_options?: #QuicProtocolOptions
	// Allows invalid HTTP messaging and headers. When this option is disabled (default), then
	// the whole HTTP/3 connection is terminated upon receiving invalid HEADERS frame. However,
	// when this option is enabled, only the offending stream is terminated.
	//
	// If set, this overrides any HCM :ref:`stream_error_on_invalid_http_messaging
	// <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.stream_error_on_invalid_http_message>`.
	override_stream_error_on_invalid_http_message?: bool
	// Allows proxying Websocket and other upgrades over HTTP/3 CONNECT using
	// the header mechanisms from the `HTTP/2 extended connect RFC
	// <https://datatracker.ietf.org/doc/html/rfc8441>`_
	// and settings `proposed for HTTP/3
	// <https://datatracker.ietf.org/doc/draft-ietf-httpbis-h3-websockets/>`_
	// Note that HTTP/3 CONNECT is not yet an RFC.
	allow_extended_connect?: bool
}

// A message to control transformations to the :scheme header
#SchemeHeaderTransformation: {
	"@type": "type.googleapis.com/envoy.config.core.v3.SchemeHeaderTransformation"
	// Overwrite any Scheme header with the contents of this string.
	scheme_to_overwrite?: string
}

// Allows pre-populating the cache with HTTP/3 alternate protocols entries with a 7 day lifetime.
// This will cause Envoy to attempt HTTP/3 to those upstreams, even if the upstreams have not
// advertised HTTP/3 support. These entries will be overwritten by alt-svc
// response headers or cached values.
// As with regular cached entries, if the origin response would result in clearing an existing
// alternate protocol cache entry, pre-populated entries will also be cleared.
// Adding a cache entry with hostname=foo.com port=123 is the equivalent of getting
// response headers
// alt-svc: h3=:"123"; ma=86400" in a response to a request to foo.com:123
#AlternateProtocolsCacheOptions_AlternateProtocolsCacheEntry: {
	"@type": "type.googleapis.com/envoy.config.core.v3.AlternateProtocolsCacheOptions_AlternateProtocolsCacheEntry"
	// The host name for the alternate protocol entry.
	hostname?: string
	// The port for the alternate protocol entry.
	port?: uint32
}

// [#next-free-field: 9]
#Http1ProtocolOptions_HeaderKeyFormat: {
	"@type": "type.googleapis.com/envoy.config.core.v3.Http1ProtocolOptions_HeaderKeyFormat"
	// Formats the header by proper casing words: the first character and any character following
	// a special character will be capitalized if it's an alpha character. For example,
	// "content-type" becomes "Content-Type", and "foo$b#$are" becomes "Foo$B#$Are".
	// Note that while this results in most headers following conventional casing, certain headers
	// are not covered. For example, the "TE" header will be formatted as "Te".
	proper_case_words?: #Http1ProtocolOptions_HeaderKeyFormat_ProperCaseWords
	// Configuration for stateful formatter extensions that allow using received headers to
	// affect the output of encoding headers. E.g., preserving case during proxying.
	// [#extension-category: envoy.http.stateful_header_formatters]
	stateful_formatter?: #TypedExtensionConfig
}

#Http1ProtocolOptions_HeaderKeyFormat_ProperCaseWords: {
	"@type": "type.googleapis.com/envoy.config.core.v3.Http1ProtocolOptions_HeaderKeyFormat_ProperCaseWords"
}

// Defines a parameter to be sent in the SETTINGS frame.
// See `RFC7540, sec. 6.5.1 <https://tools.ietf.org/html/rfc7540#section-6.5.1>`_ for details.
#Http2ProtocolOptions_SettingsParameter: {
	"@type": "type.googleapis.com/envoy.config.core.v3.Http2ProtocolOptions_SettingsParameter"
	// The 16 bit parameter identifier.
	identifier?: uint32
	// The 32 bit parameter value.
	value?: uint32
}
