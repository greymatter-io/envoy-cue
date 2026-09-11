package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Fetches the secret on-demand while allowing the parent cluster or listener to accept connections
// without warming. During the handshake, a secret name is derived from the peer hello message, an
// SDS resource request starts, and the handshake is paused. Once an SDS response is received with a
// resource, the handshake is resumed with the provided certificate. If the SDS server indicates the
// resource removal, the handshake is failed, and the SDS subscription to the resource is stopped.
//
// Similar to the regular SDS, the certificate is configured using the outer common TLS context,
// e.g. by setting the FIPS compliance policy on the loaded certificate.
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.cert_selectors.on_demand_secret.v3.Config"
	// Defines the configuration source of the secrets.
	config_source?: v3.#ConfigSource
	// Extension point to specify a function to compute the secret name. The extension is called
	// during the TLS handshake after receiving the *CLIENT HELLO* message from the client for the
	// downstream certificate selector, and using the transport socket options and *SERVER HELLO* for
	// the upstream certificate selector.
	// [#extension-category: envoy.tls.certificate_mappers,envoy.tls.upstream_certificate_mappers]
	certificate_mapper?: v3.#TypedExtensionConfig
	// A list of secret resource names to start fetching on configuration load (prior to receiving any
	// requests). The parent resource initializes immediately without waiting for the fetch to
	// complete.
	prefetch_secret_names?: [...string]
}
