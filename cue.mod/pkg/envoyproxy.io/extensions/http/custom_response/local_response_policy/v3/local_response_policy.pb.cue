package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Custom response policy to serve a locally stored response to the
// downstream.
#LocalResponsePolicy: {
	"@type": "type.googleapis.com/envoy.extensions.http.custom_response.local_response_policy.v3.LocalResponsePolicy"
	// Optional new local reply body text. It will be used
	// in the `%LOCAL_REPLY_BODY%` command operator in the `body_format`.
	body?: v3.#DataSource
	// Optional body format to be used for this response. If `body_format` is  not
	// provided, and `body` is, the contents of `body` will be used to populate
	// the body of the local reply without formatting.
	body_format?: v3.#SubstitutionFormatString
	// The new response status code if specified.
	status_code?: uint32
	// HTTP headers to add to the response. This allows the
	// response policy to append, to add or to override headers of
	// the original response for local body, or the custom response from the
	// remote body, before it is sent to a downstream client.
	response_headers_to_add?: [...v3.#HeaderValueOption]
}
