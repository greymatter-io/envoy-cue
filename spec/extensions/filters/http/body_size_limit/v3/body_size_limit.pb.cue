package v3

#BodySizeLimit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.body_size_limit.v3.BodySizeLimit"
	// The maximum request body size allowed. If the request body exceeds this limit,
	// the filter will return a 413 response.
	max_request_bytes?: uint64
}
