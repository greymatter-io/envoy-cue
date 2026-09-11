package v3

// HTTP service configuration.
#HttpService: {
	"@type": "type.googleapis.com/envoy.config.core.v3.HttpService"
	// The service's HTTP URI. For example:
	//
	// .. code-block:: yaml
	//
	//	http_uri:
	//	  uri: https://www.myserviceapi.com/v1/data
	//	  cluster: www.myserviceapi.com|443
	http_uri?: #HttpUri
	// Specifies a list of HTTP headers that should be added to each request
	// handled by this virtual host. Substitution formatters are supported.
	request_headers_to_add?: [...#HeaderValueOption]
	// Specifies a collection of Formatter plugins that can be used in substitution formatters
	// in “request_headers_to_add“.
	// See the formatters extensions documentation for details.
	// [#extension-category: envoy.formatter]
	formatters?: [...#TypedExtensionConfig]
}
