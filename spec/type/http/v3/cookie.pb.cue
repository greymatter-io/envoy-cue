package v3

// Cookie defines an API for obtaining or generating HTTP cookie.
#Cookie: {
	"@type": "type.googleapis.com/envoy.type.http.v3.Cookie"
	// The name that will be used to obtain cookie value from downstream HTTP request or generate
	// new cookie for downstream.
	name?: string
	// Duration of cookie. This will be used to set the expiry time of a new cookie when it is
	// generated. Set this to 0s to use a session cookie and disable cookie expiration.
	ttl?: string
	// Path of cookie. This will be used to set the path of a new cookie when it is generated.
	// If no path is specified here, no path will be set for the cookie.
	path?: string
	// Additional attributes for the cookie. They will be used when generating a new cookie.
	attributes?: [...#CookieAttribute]
}

// CookieAttribute defines an API for adding additional attributes for a HTTP cookie.
#CookieAttribute: {
	"@type": "type.googleapis.com/envoy.type.http.v3.CookieAttribute"
	// The name of the cookie attribute.
	name?: string
	// The optional value of the cookie attribute.
	value?: string
}
