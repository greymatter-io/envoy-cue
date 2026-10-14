package core

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
	"@type": "type.googleapis.com/envoy.api.v2.core.TcpProtocolOptions"
}

#UpstreamHttpProtocolOptions: {
	"@type": "type.googleapis.com/envoy.api.v2.core.UpstreamHttpProtocolOptions"
	// Set transport socket `SNI <https://en.wikipedia.org/wiki/Server_Name_Indication>`_ for new
	// upstream connections based on the downstream HTTP host/authority header, as seen by the
	// :ref:`router filter <config_http_filters_router>`.
	auto_sni?: bool
	// Automatic validate upstream presented certificate for new upstream connections based on the
	// downstream HTTP host/authority header, as seen by the
	// :ref:`router filter <config_http_filters_router>`.
	// This field is intended to set with `auto_sni` field.
	auto_san_validation?: bool
}

// [#next-free-field: 6]
#HttpProtocolOptions: {
	"@type": "type.googleapis.com/envoy.api.v2.core.HttpProtocolOptions"
	// The idle timeout for connections. The idle timeout is defined as the
	// period in which there are no active requests. When the
	// idle timeout is reached the connection will be closed. If the connection is an HTTP/2
	// downstream connection a drain sequence will occur prior to closing the connection, see
	// :ref:`drain_timeout
	// <envoy_api_field_config.filter.network.http_connection_manager.v2.HttpConnectionManager.drain_timeout>`.
	// Note that request based timeouts mean that HTTP/2 PINGs will not keep the connection alive.
	// If not specified, this defaults to 1 hour. To disable idle timeouts explicitly set this to 0.
	//
	// .. warning::
	//   Disabling this timeout has a highly likelihood of yielding connection leaks due to lost TCP
	//   FIN packets, etc.
	idle_timeout?: string
	// The maximum duration of a connection. The duration is defined as a period since a connection
	// was established. If not set, there is no max duration. When max_connection_duration is reached
	// the connection will be closed. Drain sequence will occur prior to closing the connection if
	// if's applicable. See :ref:`drain_timeout
	// <envoy_api_field_config.filter.network.http_connection_manager.v2.HttpConnectionManager.drain_timeout>`.
	// Note: not implemented for upstream connections.
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
	headers_with_underscores_action?: #HttpProtocolOptions_HeadersWithUnderscoresAction
}

// [#next-free-field: 6]
#Http1ProtocolOptions: {
	"@type": "type.googleapis.com/envoy.api.v2.core.Http1ProtocolOptions"
	// Handle HTTP requests with absolute URLs in the requests. These requests
	// are generally sent by clients to forward/explicit proxies. This allows clients to configure
	// envoy as their HTTP proxy. In Unix, for example, this is typically done by setting the
	// *http_proxy* environment variable.
	allow_absolute_url?: bool
	// Handle incoming HTTP/1.0 and HTTP 0.9 requests.
	// This is off by default, and not fully standards compliant. There is support for pre-HTTP/1.1
	// style connect logic, dechunking, and handling lack of client host iff
	// *default_host_for_http_10* is configured.
	accept_http_10?: bool
	// A default host for HTTP/1.0 requests. This is highly suggested if *accept_http_10* is true as
	// Envoy does not otherwise support HTTP/1.0 without a Host header.
	// This is a no-op if *accept_http_10* is not true.
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
}

// [#next-free-field: 14]
#Http2ProtocolOptions: {
	"@type": "type.googleapis.com/envoy.api.v2.core.Http2ProtocolOptions"
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
	// Similar to *initial_stream_window_size*, but for connection-level flow-control
	// window. Currently, this has the same minimum/maximum/default as *initial_stream_window_size*.
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
	// [#comment:TODO: implement same limits for upstream outbound frames as well.]
	max_outbound_frames?: uint32
	// Limit the number of pending outbound downstream frames of types PING, SETTINGS and RST_STREAM,
	// preventing high memory utilization when receiving continuous stream of these frames. Exceeding
	// this limit triggers flood mitigation and connection is terminated. The
	// ``http2.outbound_control_flood`` stat tracks the number of terminated connections due to flood
	// mitigation. The default limit is 1000.
	// [#comment:TODO: implement same limits for upstream outbound frames as well.]
	max_outbound_control_frames?: uint32
	// Limit the number of consecutive inbound frames of types HEADERS, CONTINUATION and DATA with an
	// empty payload and no end stream flag. Those frames have no legitimate use and are abusive, but
	// might be a result of a broken HTTP/2 implementation. The `http2.inbound_empty_frames_flood``
	// stat tracks the number of connections terminated due to flood mitigation.
	// Setting this to 0 will terminate connection upon receiving first frame with an empty payload
	// and no end stream flag. The default limit is 1.
	// [#comment:TODO: implement same limits for upstream inbound frames as well.]
	max_consecutive_inbound_frames_with_empty_payload?: uint32
	// Limit the number of inbound PRIORITY frames allowed per each opened stream. If the number
	// of PRIORITY frames received over the lifetime of connection exceeds the value calculated
	// using this formula::
	//
	//     max_inbound_priority_frames_per_stream * (1 + inbound_streams)
	//
	// the connection is terminated. The ``http2.inbound_priority_frames_flood`` stat tracks
	// the number of connections terminated due to flood mitigation. The default limit is 100.
	// [#comment:TODO: implement same limits for upstream inbound frames as well.]
	max_inbound_priority_frames_per_stream?: uint32
	// Limit the number of inbound WINDOW_UPDATE frames allowed per DATA frame sent. If the number
	// of WINDOW_UPDATE frames received over the lifetime of connection exceeds the value calculated
	// using this formula::
	//
	//     1 + 2 * (inbound_streams +
	//              max_inbound_window_update_frames_per_data_frame_sent * outbound_data_frames)
	//
	// the connection is terminated. The ``http2.inbound_priority_frames_flood`` stat tracks
	// the number of connections terminated due to flood mitigation. The default limit is 10.
	// Setting this to 1 should be enough to support HTTP/2 implementations with basic flow control,
	// but more complex implementations that try to estimate available bandwidth require at least 2.
	// [#comment:TODO: implement same limits for upstream inbound frames as well.]
	max_inbound_window_update_frames_per_data_frame_sent?: uint32
	// Allows invalid HTTP messaging and headers. When this option is disabled (default), then
	// the whole HTTP/2 connection is terminated upon receiving invalid HEADERS frame. However,
	// when this option is enabled, only the offending stream is terminated.
	//
	// See `RFC7540, sec. 8.1 <https://tools.ietf.org/html/rfc7540#section-8.1>`_ for details.
	stream_error_on_invalid_http_messaging?: bool
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
}

// [#not-implemented-hide:]
#GrpcProtocolOptions: {
	"@type":                 "type.googleapis.com/envoy.api.v2.core.GrpcProtocolOptions"
	http2_protocol_options?: #Http2ProtocolOptions
}

#Http1ProtocolOptions_HeaderKeyFormat: {
	"@type": "type.googleapis.com/envoy.api.v2.core.Http1ProtocolOptions_HeaderKeyFormat"
	// Formats the header by proper casing words: the first character and any character following
	// a special character will be capitalized if it's an alpha character. For example,
	// "content-type" becomes "Content-Type", and "foo$b#$are" becomes "Foo$B#$Are".
	// Note that while this results in most headers following conventional casing, certain headers
	// are not covered. For example, the "TE" header will be formatted as "Te".
	proper_case_words?: #Http1ProtocolOptions_HeaderKeyFormat_ProperCaseWords
}

#Http1ProtocolOptions_HeaderKeyFormat_ProperCaseWords: {
	"@type": "type.googleapis.com/envoy.api.v2.core.Http1ProtocolOptions_HeaderKeyFormat_ProperCaseWords"
}

// Defines a parameter to be sent in the SETTINGS frame.
// See `RFC7540, sec. 6.5.1 <https://tools.ietf.org/html/rfc7540#section-6.5.1>`_ for details.
#Http2ProtocolOptions_SettingsParameter: {
	"@type": "type.googleapis.com/envoy.api.v2.core.Http2ProtocolOptions_SettingsParameter"
	// The 16 bit parameter identifier.
	identifier?: uint32
	// The 32 bit parameter value.
	value?: uint32
}
