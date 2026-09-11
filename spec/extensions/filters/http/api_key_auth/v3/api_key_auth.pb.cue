package v3

// API Key HTTP authentication.
//
// For example, the following configuration configures the filter to authenticate the clients using
// the API key from the header “X-API-KEY“. And only the clients with the key “real-key“ are
// considered as authenticated. The client information is configured to be forwarded
// in the header “x-client-id“.
//
// .. code-block:: yaml
//
//	credentials:
//	- key: real-key
//	  client: user
//	key_sources:
//	 - header: "X-API-KEY"
//	forwarding:
//	  header: "x-client-id"
//	  hide_credentials: false
#ApiKeyAuth: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.api_key_auth.v3.ApiKeyAuth"
	// The credentials that are used to authenticate the clients.
	credentials?: [...#Credential]
	// The key sources to fetch the key from the coming request.
	key_sources?: [...#KeySource]
	// Optional configuration to control what information should be propagated to upstream services.
	forwarding?: #Forwarding
}

// API key auth configuration of per route or per virtual host or per route configuration.
#ApiKeyAuthPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.api_key_auth.v3.ApiKeyAuthPerRoute"
	// The credentials that are used to authenticate the clients. If this field is non-empty, then the
	// credentials in the filter level configuration will be ignored and the credentials in this
	// configuration will be used.
	credentials?: [...#Credential]
	// The key sources to fetch the key from the coming request. If this field is non-empty, then the
	// key sources in the filter level configuration will be ignored and the key sources in this
	// configuration will be used.
	key_sources?: [...#KeySource]
	// A list of clients that are allowed to access the route or vhost. The clients listed here
	// should be subset of the clients listed in the “credentials“ to provide authorization control
	// after the authentication is successful. If the list is empty, then all authenticated clients
	// are allowed. This provides very limited but simple authorization. If more complex authorization
	// is required, then use the :ref:`HTTP RBAC filter <config_http_filters_rbac>` instead.
	//
	// .. note::
	//
	//	Setting this field and ``credentials`` at the same configuration entry is not an error but
	//	also makes no much sense because they provide similar functionality. Please only use
	//	one of them at same configuration entry except for the case that you want to share the same
	//	credentials list across multiple routes but still use different allowed clients for each
	//	route.
	allowed_clients?: [...string]
	// Optional configuration to control what information should be propagated to upstream services.
	// If this field is non-empty, then the forwarding information in the filter level configuration
	// will be ignored and the forwarding in this configuration will be used.
	forwarding?: #Forwarding
}

// Single credential entry that contains the API key and the related client id.
#Credential: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.api_key_auth.v3.Credential"
	// The value of the unique API key.
	key?: string
	// The unique id or identity that used to identify the client or consumer.
	client?: string
}

#KeySource: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.api_key_auth.v3.KeySource"
	// The header name to fetch the key. If multiple header values are present, the first one will be
	// used. If the header value starts with 'Bearer ', this prefix will be stripped to get the
	// key value.
	//
	// If set, takes precedence over “query“ and “cookie“.
	header?: string
	// The query parameter name to fetch the key. If multiple query values are present, the first one
	// will be used.
	//
	// The field will be used if “header“ is not set. If set, takes precedence over “cookie“.
	query?: string
	// The cookie name to fetch the key.
	//
	// The field will be used if the “header“ and “query“ are not set.
	cookie?: string
}

#Forwarding: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.api_key_auth.v3.Forwarding"
	// The header name in which to store the client information. If this field is non-empty,
	// the client string associated with the matched credential will be injected into
	// the request before forwarding upstream.
	header?: string
	// If true, remove the API key from the request before forwarding upstream.
	//
	// This applies to all configured key sources: “header“, “query“, and “cookie“.
	hide_credentials?: bool
}
