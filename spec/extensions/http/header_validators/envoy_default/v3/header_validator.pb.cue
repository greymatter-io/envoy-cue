package v3

// Action to take when Envoy receives client request with header names containing underscore
// characters.
// Underscore character is allowed in header names by the RFC-7230 and this behavior is implemented
// as a security measure due to systems that treat '_' and '-' as interchangeable. Envoy by default allows client request headers with underscore
// characters.
#HeaderValidatorConfig_HeadersWithUnderscoresAction: "ALLOW" | "REJECT_REQUEST" | "DROP_HEADER"

HeaderValidatorConfig_HeadersWithUnderscoresAction_ALLOW:          "ALLOW"
HeaderValidatorConfig_HeadersWithUnderscoresAction_REJECT_REQUEST: "REJECT_REQUEST"
HeaderValidatorConfig_HeadersWithUnderscoresAction_DROP_HEADER:    "DROP_HEADER"

// Determines the action for requests that contain ``%2F``, ``%2f``, ``%5C`` or ``%5c`` sequences in the URI path.
// This operation occurs before URL normalization and the merge slashes transformations if they were enabled.
#HeaderValidatorConfig_UriPathNormalizationOptions_PathWithEscapedSlashesAction: "IMPLEMENTATION_SPECIFIC_DEFAULT" | "KEEP_UNCHANGED" | "REJECT_REQUEST" | "UNESCAPE_AND_REDIRECT" | "UNESCAPE_AND_FORWARD"

HeaderValidatorConfig_UriPathNormalizationOptions_PathWithEscapedSlashesAction_IMPLEMENTATION_SPECIFIC_DEFAULT: "IMPLEMENTATION_SPECIFIC_DEFAULT"
HeaderValidatorConfig_UriPathNormalizationOptions_PathWithEscapedSlashesAction_KEEP_UNCHANGED:                  "KEEP_UNCHANGED"
HeaderValidatorConfig_UriPathNormalizationOptions_PathWithEscapedSlashesAction_REJECT_REQUEST:                  "REJECT_REQUEST"
HeaderValidatorConfig_UriPathNormalizationOptions_PathWithEscapedSlashesAction_UNESCAPE_AND_REDIRECT:           "UNESCAPE_AND_REDIRECT"
HeaderValidatorConfig_UriPathNormalizationOptions_PathWithEscapedSlashesAction_UNESCAPE_AND_FORWARD:            "UNESCAPE_AND_FORWARD"

// This extension validates that HTTP request and response headers are well formed according to respective RFCs.
//
// #. HTTP/1 header map validity according to `RFC 7230 section 3.2 <https://datatracker.ietf.org/doc/html/rfc7230#section-3.2>`_
// #. Syntax of HTTP/1 request target URI and response status
// #. HTTP/2 header map validity according to `RFC 7540 section 8.1.2 <https://datatracker.ietf.org/doc/html/rfc7540#section-8.1.2>`_
// #. Syntax of HTTP/2 pseudo headers
// #. HTTP/3 header map validity according to `RFC 9114 section 4.3  <https://www.rfc-editor.org/rfc/rfc9114.html>`_
// #. Syntax of HTTP/3 pseudo headers
// #. Syntax of Content-Length and Transfer-Encoding
// #. Validation of HTTP/1 requests with both ``Content-Length`` and ``Transfer-Encoding`` headers
// #. Normalization of the URI path according to `Normalization and Comparison <https://datatracker.ietf.org/doc/html/rfc3986#section-6>`_
//    without `case normalization <https://datatracker.ietf.org/doc/html/rfc3986#section-6.2.2.1>`_
//
#HeaderValidatorConfig: {
	"@type":                 "type.googleapis.com/envoy.extensions.http.header_validators.envoy_default.v3.HeaderValidatorConfig"
	http1_protocol_options?: #HeaderValidatorConfig_Http1ProtocolOptions
	// The URI path normalization options.
	// By default Envoy normalizes URI path using the default values of the :ref:`UriPathNormalizationOptions
	// <envoy_v3_api_msg_extensions.http.header_validators.envoy_default.v3.HeaderValidatorConfig.UriPathNormalizationOptions>`.
	// URI path transformations specified by the ``uri_path_normalization_options`` configuration can be applied to a portion
	// of requests by setting the ``envoy_default_header_validator.uri_path_transformations`` runtime value.
	// Caution: disabling path normalization may lead to path confusion vulnerabilities in access control or incorrect service
	// selection.
	uri_path_normalization_options?: #HeaderValidatorConfig_UriPathNormalizationOptions
	// Restrict HTTP methods to these defined in the `RFC 7231 section 4.1 <https://datatracker.ietf.org/doc/html/rfc7231#section-4.1>`_
	// Envoy will respond with 400 to requests with disallowed methods.
	// By default methods with arbitrary names are accepted.
	restrict_http_methods?: bool
	// Action to take when a client request with a header name containing underscore characters is received.
	// If this setting is not specified, the value defaults to ALLOW.
	headers_with_underscores_action?: #HeaderValidatorConfig_HeadersWithUnderscoresAction
}

#HeaderValidatorConfig_UriPathNormalizationOptions: {
	"@type": "type.googleapis.com/envoy.extensions.http.header_validators.envoy_default.v3.HeaderValidatorConfig_UriPathNormalizationOptions"
	// Should paths be normalized according to RFC 3986?
	// This operation overwrites the original request URI path and the new path is used for processing of
	// the request by HTTP filters and proxied to the upstream service.
	// Envoy will respond with 400 to requests with malformed paths that fail path normalization.
	// The default behavior is to normalize the path.
	// This value may be overridden by the runtime variable
	// :ref:`http_connection_manager.normalize_path<config_http_conn_man_runtime_normalize_path>`.
	// See `Normalization and Comparison <https://datatracker.ietf.org/doc/html/rfc3986#section-6>`_
	// for details of normalization.
	// Note that Envoy does not perform
	// `case normalization <https://datatracker.ietf.org/doc/html/rfc3986#section-6.2.2.1>`_
	// URI path normalization can be applied to a portion of requests by setting the
	// ``envoy_default_header_validator.path_normalization`` runtime value.
	skip_path_normalization?: bool
	// Determines if adjacent slashes in the path are merged into one.
	// This operation overwrites the original request URI path and the new path is used for processing of
	// the request by HTTP filters and proxied to the upstream service.
	// Setting this option to true will cause incoming requests with path ``//dir///file`` to not match against
	// route with ``prefix`` match set to ``/dir``. Defaults to ``false``. Note that slash merging is not part of
	// `HTTP spec <https://datatracker.ietf.org/doc/html/rfc3986>`_ and is provided for convenience.
	// Merging of slashes in URI path can be applied to a portion of requests by setting the
	// ``envoy_default_header_validator.merge_slashes`` runtime value.
	skip_merging_slashes?: bool
	// The action to take when request URL path contains escaped slash sequences (``%2F``, ``%2f``, ``%5C`` and ``%5c``).
	// This operation may overwrite the original request URI path and the new path is used for processing of
	// the request by HTTP filters and proxied to the upstream service.
	path_with_escaped_slashes_action?: #HeaderValidatorConfig_UriPathNormalizationOptions_PathWithEscapedSlashesAction
}

#HeaderValidatorConfig_Http1ProtocolOptions: {
	"@type": "type.googleapis.com/envoy.extensions.http.header_validators.envoy_default.v3.HeaderValidatorConfig_Http1ProtocolOptions"
	// Allows Envoy to process HTTP/1 requests/responses with both ``Content-Length`` and ``Transfer-Encoding``
	// headers set. By default such messages are rejected, but if option is enabled - Envoy will
	// remove the ``Content-Length`` header and process the message.
	// See `RFC7230, sec. 3.3.3 <https://datatracker.ietf.org/doc/html/rfc7230#section-3.3.3>`_ for details.
	//
	// .. attention::
	//   Enabling this option might lead to request smuggling vulnerabilities, especially if traffic
	//   is proxied via multiple layers of proxies.
	allow_chunked_length?: bool
}
