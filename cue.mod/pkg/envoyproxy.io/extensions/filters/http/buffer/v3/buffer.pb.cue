package v3

import (
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

#Buffer: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.buffer.v3.Buffer"
	// The maximum request size that the filter will buffer before the connection
	// manager will stop buffering and return a 413 response.
	max_request_bytes?: wrapperspb.#UInt32Value
}

#BufferPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.buffer.v3.BufferPerRoute"
	// Disable the buffer filter for this particular vhost or route.
	disabled?: bool
	// Override the global configuration of the filter with this new config.
	buffer?: #Buffer
}
