package v3

// Match input indicates that matching should be done on the response status
// code.
#HttpResponseStatusCodeMatchInput: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.HttpResponseStatusCodeMatchInput"
}

// Match input indicates that the matching should be done on the class of the
// response status code. For eg: 1xx, 2xx, 3xx, 4xx or 5xx.
#HttpResponseStatusCodeClassMatchInput: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.HttpResponseStatusCodeClassMatchInput"
}
