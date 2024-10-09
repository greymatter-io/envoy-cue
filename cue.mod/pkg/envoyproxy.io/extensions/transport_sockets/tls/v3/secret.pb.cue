package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

#GenericSecret: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.GenericSecret"
	// Secret of generic type and is available to filters.
	secret?: v3.#DataSource
}

#SdsSecretConfig: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.SdsSecretConfig"
	// Name by which the secret can be uniquely referred to. When both name and config are specified,
	// then secret can be fetched and/or reloaded via SDS. When only name is specified, then secret
	// will be loaded from static resources.
	name?:       string
	sds_config?: v3.#ConfigSource
}

// [#next-free-field: 6]
#Secret: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.Secret"
	// Name (FQDN, UUID, SPKI, SHA256, etc.) by which the secret can be uniquely referred to.
	name?:                string
	tls_certificate?:     #TlsCertificate
	session_ticket_keys?: #TlsSessionTicketKeys
	validation_context?:  #CertificateValidationContext
	generic_secret?:      #GenericSecret
}
