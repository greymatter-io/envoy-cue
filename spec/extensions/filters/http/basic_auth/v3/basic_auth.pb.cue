package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Basic HTTP authentication.
//
// Example:
//
// .. code-block:: yaml
//
//	users:
//	  inline_string: |-
//	    user1:{SHA}hashed_user1_password
//	    user2:{SHA}hashed_user2_password
//
// [#next-free-field: 6]
#BasicAuth: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.basic_auth.v3.BasicAuth"
	// Username-password pairs used to verify user credentials in the "Authorization" header.
	// The value needs to be the htpasswd format.
	// Reference to https://httpd.apache.org/docs/2.4/programs/htpasswd.html
	users?: v3.#DataSource
	// This field specifies the header name to forward a successfully authenticated user to
	// the backend. The header will be added to the request with the username as the value.
	//
	// If it is not specified, the username will not be forwarded.
	forward_username_header?: string
	// This field specifies the request header to load the basic credential from.
	//
	// If it is not specified, the filter loads the credential from  the "Authorization" header.
	authentication_header?: string
	// If set to true, requests without Basic credentials (missing “Authorization“ header, or
	// “Authorization“ header with a non-“Basic“ scheme such as “Bearer“) are allowed to pass through
	// without authentication. Requests that present “Basic“ credentials are still fully validated.
	//
	// This is useful when combining BasicAuth with other authentication methods (e.g. JWT) to
	// achieve OR semantics: a request is accepted if any one configured auth method succeeds.
	// When “allow_missing“ is “true“ on all auth filters, pair it with an RBAC filter that checks
	// the dynamic metadata emitted by this filter (see “emit_dynamic_metadata“) to ensure at
	// least one method authenticated the request. Requires “emit_dynamic_metadata“ to be set to
	// “true“.
	allow_missing?: bool
	// If set to “true“, the filter emits dynamic metadata on successful authentication with key
	// “username“ set to the authenticated username. The metadata is emitted under the namespace
	// corresponding to the name of this basic_auth filter as configured in the “http_filters“
	// chain (e.g. if the filter is configured with name “envoy.filters.http.basic_auth“, that is
	// the namespace that will be used).
	//
	// This is typically enabled together with “allow_missing“ when combining BasicAuth with
	// other authentication methods (e.g. JWT) and using a downstream RBAC filter to enforce
	// OR semantics.
	emit_dynamic_metadata?: bool
}

// Extra settings that may be added to per-route configuration for
// a virtual host or a cluster.
#BasicAuthPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.basic_auth.v3.BasicAuthPerRoute"
	// Username-password pairs for this route.
	users?: v3.#DataSource
}
