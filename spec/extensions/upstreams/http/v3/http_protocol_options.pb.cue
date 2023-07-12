package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/extensions/filters/network/http_connection_manager/v3"
)

// HttpProtocolOptions specifies Http upstream protocol options. This object
// is used in
// :ref:`typed_extension_protocol_options<envoy_v3_api_field_config.cluster.v3.Cluster.typed_extension_protocol_options>`,
// keyed by the name ``envoy.extensions.upstreams.http.v3.HttpProtocolOptions``.
//
// This controls what protocol(s) should be used for upstream and how said protocol(s) are configured.
//
// This replaces the prior pattern of explicit protocol configuration directly
// in the cluster. So a configuration like this, explicitly configuring the use of HTTP/2 upstream:
//
// .. code::
//
//   clusters:
//     - name: some_service
//       connect_timeout: 5s
//       upstream_http_protocol_options:
//         auto_sni: true
//       common_http_protocol_options:
//         idle_timeout: 1s
//       http2_protocol_options:
//         max_concurrent_streams: 100
//        .... [further cluster config]
//
// Would now look like this:
//
// .. code::
//
//   clusters:
//     - name: some_service
//       connect_timeout: 5s
//       typed_extension_protocol_options:
//         envoy.extensions.upstreams.http.v3.HttpProtocolOptions:
//           "@type": type.googleapis.com/envoy.extensions.upstreams.http.v3.HttpProtocolOptions
//           upstream_http_protocol_options:
//             auto_sni: true
//           common_http_protocol_options:
//             idle_timeout: 1s
//           explicit_http_config:
//             http2_protocol_options:
//               max_concurrent_streams: 100
//        .... [further cluster config]
// [#next-free-field: 7]
#HttpProtocolOptions: {
	"@type": "type.googleapis.com/envoy.extensions.upstreams.http.v3.HttpProtocolOptions"
	// This contains options common across HTTP/1 and HTTP/2
	common_http_protocol_options?: v3.#HttpProtocolOptions
	// This contains common protocol options which are only applied upstream.
	upstream_http_protocol_options?: v3.#UpstreamHttpProtocolOptions
	// To explicitly configure either HTTP/1 or HTTP/2 (but not both!) use ``explicit_http_config``.
	// If the ``explicit_http_config`` is empty, HTTP/1.1 is used.
	explicit_http_config?: #HttpProtocolOptions_ExplicitHttpConfig
	// This allows switching on protocol based on what protocol the downstream
	// connection used.
	use_downstream_protocol_config?: #HttpProtocolOptions_UseDownstreamHttpConfig
	// This allows switching on protocol based on ALPN
	auto_config?: #HttpProtocolOptions_AutoHttpConfig
	// .. warning::
	//   Upstream HTTP filters are not supported by default.
	//   This warning will be removed as support moves beyond alpha.
	//
	// Optional HTTP filters for the upstream filter chain.
	//
	// These filters will be applied for all HTTP streams which flow through this
	// cluster. Unlike downstream filters, they will *not* be applied to terminated CONNECT requests.
	//
	// If using upstream filters, please be aware that local errors sent by
	// upstream filters will not trigger retries, and local errors sent by
	// upstream filters will count as a final response if hedging is configured.
	// [#extension-category: envoy.filters.http.upstream]
	http_filters?: [...v31.#HttpFilter]
}

// If this is used, the cluster will only operate on one of the possible upstream protocols.
// Note that HTTP/2 or above should generally be used for upstream gRPC clusters.
#HttpProtocolOptions_ExplicitHttpConfig: {
	"@type":                 "type.googleapis.com/envoy.extensions.upstreams.http.v3.HttpProtocolOptions_ExplicitHttpConfig"
	http_protocol_options?:  v3.#Http1ProtocolOptions
	http2_protocol_options?: v3.#Http2ProtocolOptions
	// .. warning::
	//   QUIC upstream support is currently not ready for internet use.
	//   Please see :ref:`here <arch_overview_http3>` for details.
	http3_protocol_options?: v3.#Http3ProtocolOptions
}

// If this is used, the cluster can use either of the configured protocols, and
// will use whichever protocol was used by the downstream connection.
//
// If HTTP/3 is configured for downstream and not configured for upstream,
// HTTP/3 requests will fail over to HTTP/2.
#HttpProtocolOptions_UseDownstreamHttpConfig: {
	"@type":                 "type.googleapis.com/envoy.extensions.upstreams.http.v3.HttpProtocolOptions_UseDownstreamHttpConfig"
	http_protocol_options?:  v3.#Http1ProtocolOptions
	http2_protocol_options?: v3.#Http2ProtocolOptions
	// .. warning::
	//   QUIC upstream support is currently not ready for internet use.
	//   Please see :ref:`here <arch_overview_http3>` for details.
	http3_protocol_options?: v3.#Http3ProtocolOptions
}

// If this is used, the cluster can use either HTTP/1 or HTTP/2, and will use whichever
// protocol is negotiated by ALPN with the upstream.
// Clusters configured with ``AutoHttpConfig`` will use the highest available
// protocol; HTTP/2 if supported, otherwise HTTP/1.
// If the upstream does not support ALPN, ``AutoHttpConfig`` will fail over to HTTP/1.
// This can only be used with transport sockets which support ALPN. Using a
// transport socket which does not support ALPN will result in configuration
// failure. The transport layer may be configured with custom ALPN, but the default ALPN
// for the cluster (or if custom ALPN fails) will be "h2,http/1.1".
#HttpProtocolOptions_AutoHttpConfig: {
	"@type":                 "type.googleapis.com/envoy.extensions.upstreams.http.v3.HttpProtocolOptions_AutoHttpConfig"
	http_protocol_options?:  v3.#Http1ProtocolOptions
	http2_protocol_options?: v3.#Http2ProtocolOptions
	// Unlike HTTP/1 and HTTP/2, HTTP/3 will not be configured unless it is
	// present, and (soon) only if there is an indication of server side
	// support.
	// See :ref:`here <arch_overview_http3_upstream>` for more information on
	// when HTTP/3 will be used, and when Envoy will fail over to TCP.
	//
	// .. warning::
	//   QUIC upstream support is currently not ready for internet use.
	//   Please see :ref:`here <arch_overview_http3>` for details.
	http3_protocol_options?: v3.#Http3ProtocolOptions
	// The presence of alternate protocols cache options causes the use of the
	// alternate protocols cache, which is responsible for parsing and caching
	// HTTP Alt-Svc headers. This enables the use of HTTP/3 for origins that
	// advertise supporting it.
	//
	// .. note::
	//   This is required when HTTP/3 is enabled.
	alternate_protocols_cache_options?: v3.#AlternateProtocolsCacheOptions
}
