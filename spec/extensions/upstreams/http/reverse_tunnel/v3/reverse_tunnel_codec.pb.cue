package v3

// Configuration for the drain-aware reverse-tunnel upstream codec.
#ReverseTunnelUpstreamCodecOptions: {
	"@type": "type.googleapis.com/envoy.extensions.upstreams.http.reverse_tunnel.v3.ReverseTunnelUpstreamCodecOptions"
	// When true, the upstream HTTP/2 client codec emits a GOAWAY when the reverse tunnel begins
	// draining. Defaults to false, in which case the stock HTTP/2 client codec is used unchanged.
	enable_drain_with_goaway?: bool
}
