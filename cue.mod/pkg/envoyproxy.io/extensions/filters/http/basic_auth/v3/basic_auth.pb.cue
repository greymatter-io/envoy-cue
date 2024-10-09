package v3

import (
	v3 "envoyproxy.io/config/core/v3"
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
}

// Extra settings that may be added to per-route configuration for
// a virtual host or a cluster.
#BasicAuthPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.basic_auth.v3.BasicAuthPerRoute"
	// Username-password pairs for this route.
	users?: v3.#DataSource
}
