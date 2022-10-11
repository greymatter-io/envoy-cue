package v3

// Cookie defines an API for obtaining or generating HTTP cookie.
#Cookie: {
	"@type": "type.googleapis.com/envoy.type.http.v3.Cookie"
	// The name that will be used to obtain cookie value from downstream HTTP request or generate
	// new cookie for downstream.
	name?: string
	// Duration of cookie. This will be used to set the expiry time of a new cookie when it is
	// generated. Set this to 0 to use a session cookie.
	ttl?: string
	// Path of cookie. This will be used to set the path of a new cookie when it is generated.
	// If no path is specified here, no path will be set for the cookie.
	path?: string
}
