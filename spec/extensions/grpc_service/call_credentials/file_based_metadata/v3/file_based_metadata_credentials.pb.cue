package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// [#not-implemented-hide:]
#FileBasedMetadataCallCredentials: {
	"@type": "type.googleapis.com/envoy.extensions.grpc_service.call_credentials.file_based_metadata.v3.FileBasedMetadataCallCredentials"
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
