package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

#FileBasedMetadataConfig: {
	"@type": "type.googleapis.com/envoy.config.grpc_credential.v3.FileBasedMetadataConfig"
	// Location or inline data of secret to use for authentication of the Google gRPC connection
	// this secret will be attached to a header of the gRPC connection
	secret_data?: v3.#DataSource
	// Metadata header key to use for sending the secret data
	// if no header key is set, "authorization" header will be used
	header_key?: string
	// Prefix to prepend to the secret in the metadata header
	// if no prefix is set, the default is to use no prefix
	header_prefix?: string
}
