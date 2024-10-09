package v3

import (
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
)

// Cookie defines an API for obtaining or generating HTTP cookie.
#Cookie: {
	"@type": "type.googleapis.com/envoy.type.http.v3.Cookie"
	// The name that will be used to obtain cookie value from downstream HTTP request or generate
	// new cookie for downstream.
	name?: string
	// Duration of cookie. This will be used to set the expiry time of a new cookie when it is
	// generated. Set this to 0s to use a session cookie and disable cookie expiration.
	ttl?: durationpb.#Duration
	// Path of cookie. This will be used to set the path of a new cookie when it is generated.
	// If no path is specified here, no path will be set for the cookie.
	path?: string
}
