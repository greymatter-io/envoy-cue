package core

// Envoy external URI descriptor
#HttpUri: {
	"@type": "type.googleapis.com/envoy.api.v2.core.HttpUri"
	// The HTTP server URI. It should be a full FQDN with protocol, host and path.
	//
	// Example:
	//
	// .. code-block:: yaml
	//
	//    uri: https://www.googleapis.com/oauth2/v1/certs
	//
	uri?: string
	// A cluster is created in the Envoy "cluster_manager" config
	// section. This field specifies the cluster name.
	//
	// Example:
	//
	// .. code-block:: yaml
	//
	//    cluster: jwks_cluster
	//
	cluster?: string
	// Sets the maximum duration in milliseconds that a response can take to arrive upon request.
	timeout?: string
}
