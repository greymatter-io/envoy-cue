package v3

// Match input indicates that matching should be done on a specific request header.
// The resulting input string will be all headers for the given key joined by a comma,
// e.g. if the request contains two 'foo' headers with value 'bar' and 'baz', the input
// string will be 'bar,baz'.
// [#comment:TODO(snowp): Link to unified matching docs.]
// [#extension: envoy.matching.inputs.request_headers]
#HttpRequestHeaderMatchInput: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.HttpRequestHeaderMatchInput"
	// The request header to match on.
	header_name?: string
}

// Match input indicates that matching should be done on a specific request trailer.
// The resulting input string will be all headers for the given key joined by a comma,
// e.g. if the request contains two 'foo' headers with value 'bar' and 'baz', the input
// string will be 'bar,baz'.
// [#comment:TODO(snowp): Link to unified matching docs.]
// [#extension: envoy.matching.inputs.request_trailers]
#HttpRequestTrailerMatchInput: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.HttpRequestTrailerMatchInput"
	// The request trailer to match on.
	header_name?: string
}

// Match input indicating that matching should be done on a specific response header.
// The resulting input string will be all headers for the given key joined by a comma,
// e.g. if the response contains two 'foo' headers with value 'bar' and 'baz', the input
// string will be 'bar,baz'.
// [#comment:TODO(snowp): Link to unified matching docs.]
// [#extension: envoy.matching.inputs.response_headers]
#HttpResponseHeaderMatchInput: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.HttpResponseHeaderMatchInput"
	// The response header to match on.
	header_name?: string
}

// Match input indicates that matching should be done on a specific response trailer.
// The resulting input string will be all headers for the given key joined by a comma,
// e.g. if the request contains two 'foo' headers with value 'bar' and 'baz', the input
// string will be 'bar,baz'.
// [#comment:TODO(snowp): Link to unified matching docs.]
// [#extension: envoy.matching.inputs.response_trailers]
#HttpResponseTrailerMatchInput: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.HttpResponseTrailerMatchInput"
	// The response trailer to match on.
	header_name?: string
}
