package v3

#Buffer: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.buffer.v3.Buffer"
	// The maximum request size that the filter will buffer before the connection
	// manager will stop buffering and return a 413 response.
	max_request_bytes?: uint32
}

#BufferPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.buffer.v3.BufferPerRoute"
	// Disable the buffer filter for this particular vhost or route.
	disabled?: bool
	// Override the global configuration of the filter with this new config.
	buffer?: #Buffer
}
