package v2alpha

import (
	core "envoyproxy.io/api/v2/core"
)

#FileBasedMetadataConfig: {
	"@type": "type.googleapis.com/envoy.config.grpc_credential.v2alpha.FileBasedMetadataConfig"
	// Location or inline data of secret to use for authentication of the Google gRPC connection
	// this secret will be attached to a header of the gRPC connection
	secret_data?: core.#DataSource
	// Metadata header key to use for sending the secret data
	// if no header key is set, "authorization" header will be used
	header_key?: string
	// Prefix to prepend to the secret in the metadata header
	// if no prefix is set, the default is to use no prefix
	header_prefix?: string
}
