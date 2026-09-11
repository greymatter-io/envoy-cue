package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/transport_sockets/tls/v3"
)

// GenericSecret formatter extension implements the “%SECRET(name)%“ command operator that
// resolves the value of a named generic secret obtained via SDS or static bootstrap configuration.
//
// The secret must be a :ref:`GenericSecret <envoy_v3_api_msg_extensions.transport_sockets.tls.v3.GenericSecret>`
// with the “secret“ field set.
//
// Example configuration adding an authorization header with a secret obtained via SDS:
//
// .. code-block:: yaml
//
//	http_uri:
//	  uri: https://api.example.com/v1/data
//	  cluster: api_backend
//	  timeout: 5s
//	request_headers_to_add:
//	- header:
//	    key: "authorization"
//	    value: "Bearer %SECRET(my-api-token)%"
//	formatters:
//	- name: envoy.formatter.generic_secret
//	  typed_config:
//	    "@type": type.googleapis.com/envoy.extensions.formatter.generic_secret.v3.GenericSecret
//	    secret_configs:
//	      my-api-token:
//	        name: bearer-token
//	        sds_config:
//	          ads: {}
#GenericSecret: {
	"@type": "type.googleapis.com/envoy.extensions.formatter.generic_secret.v3.GenericSecret"
	// Map from formatter lookup name to SDS secret configuration. The map key is the name used
	// in the “%SECRET(name)%“ command operator.
	secret_configs?: [string]: v3.#SdsSecretConfig
}
