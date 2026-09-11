package v3

// Upstream protocols
#FilterConfig_Protocol: "HTTP10" | "HTTP11" | "HTTP2"

FilterConfig_Protocol_HTTP10: "HTTP10"
FilterConfig_Protocol_HTTP11: "HTTP11"
FilterConfig_Protocol_HTTP2:  "HTTP2"

// FilterConfig is the config for Istio-specific filter.
#FilterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.alpn.v3.FilterConfig"
	// Map from upstream protocol to list of ALPN
	alpn_override?: [...#FilterConfig_AlpnOverride]
}

#FilterConfig_AlpnOverride: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.alpn.v3.FilterConfig_AlpnOverride"
	// Upstream protocol
	upstream_protocol?: #FilterConfig_Protocol
	// A list of ALPN that will override the ALPN for upstream TLS connections.
	alpn_override?: [...string]
}
