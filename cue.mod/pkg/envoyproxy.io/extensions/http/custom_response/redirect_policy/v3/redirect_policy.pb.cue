package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Custom response policy to internally redirect the original response to a different
// upstream.
// [#next-free-field: 7]
#RedirectPolicy: {
	"@type": "type.googleapis.com/envoy.extensions.http.custom_response.redirect_policy.v3.RedirectPolicy"
	// [#comment: TODO(pradeepcrao): Add the ability to specify the full uri, or just host or
	// path rewrite for the redirection in the same vein as
	// config.route.v3.RedirectAction]
	// The host that will serve the custom response.
	//
	// Example:
	//
	// .. code-block:: yaml
	//
	//    uri: https://www.mydomain.com
	//
	host?: string
	// The path for the custom response.
	//
	// Example:
	//
	//  .. code-block:: yaml
	//
	//    path: /path/to/503_response.txt
	//
	path?: string
	// The new response status code if specified. This is used to override the
	// status code of the response from the new upstream if it is not an error status.
	status_code?: uint32
	// HTTP headers to add to the response. This allows the
	// response policy to append, to add or to override headers of
	// the original response for local body, or the custom response from the
	// remote body, before it is sent to a downstream client.
	// Note that these are not applied if the redirected response is an error
	// response.
	response_headers_to_add?: [...v3.#HeaderValueOption]
	// HTTP headers to add to the request before it is internally redirected.
	request_headers_to_add?: [...v3.#HeaderValueOption]
	// Custom action to modify request headers before selection of the
	// redirected route.
	// [#comment: TODO(pradeepcrao) add an extension category.]
	modify_request_headers_action?: v3.#TypedExtensionConfig
}