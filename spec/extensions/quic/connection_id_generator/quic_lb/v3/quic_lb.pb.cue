package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/extensions/transport_sockets/tls/v3"
)

// Configuration for a connection ID generator implementation for the QUIC-LB draft RFC for
// routable connection IDs.
//
// Connection IDs always have the length self encoded, as described in
// https://datatracker.ietf.org/doc/html/draft-ietf-quic-load-balancers#name-length-self-description.
//
// See https://datatracker.ietf.org/doc/html/draft-ietf-quic-load-balancers for details.
//
// .. warning::
//
//	This is still a work in progress. Interoperability testing has not yet been performed.
//
// [#next-free-field: 7]
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.quic.connection_id_generator.quic_lb.v3.Config"
	// Must be at least 1 octet.
	// The length of server_id and nonce_length_bytes must be 18 or less.
	// See https://datatracker.ietf.org/doc/html/draft-ietf-quic-load-balancers#name-server-id-allocation.
	server_id?: v3.#DataSource
	// If true, indicates that the :ref:`server_id
	// <envoy_v3_api_field_extensions.quic.connection_id_generator.quic_lb.v3.Config.server_id>` is base64 encoded.
	//
	// This can be useful if the ID may contain binary data and must be transmitted as a string, for example in
	// an environment variable.
	server_id_base64_encoded?: bool
	// Optional validation of the expected server ID length. If this is non-zero and the value in “server_id“
	// does not have a matching length, a configuration error is generated. This can be useful for validating
	// that the server ID is valid.
	expected_server_id_length?: uint32
	// The nonce length must be at least 4 bytes.
	// The length of server_id and nonce_length_bytes must be 18 bytes or less.
	nonce_length_bytes?: uint32
	// Configuration to fetch the encryption key and configuration version.
	//
	// The SDS service is for a :ref:`GenericSecret <envoy_v3_api_msg_extensions.transport_sockets.tls.v3.GenericSecret>`.
	// The data should populate :ref:`secrets <envoy_v3_api_field_extensions.transport_sockets.tls.v3.GenericSecret.secrets>`:
	//
	// "encryption_key" must contain the 16 byte encryption key.
	//
	// "configuration_version" must contain a 1 byte unsigned integer of value less than 7.
	// See https://datatracker.ietf.org/doc/html/draft-ietf-quic-load-balancers#name-config-rotation.
	encryption_parameters?: v31.#SdsSecretConfig
	// Use the unencrypted mode. This is useful for testing or a simplified implementation of the
	// downstream load balancer, but allows for linking different CIDs for the same connection, and
	// leaks information about the valid server IDs in use. This mode does not comply with the RFC.
	//
	// Note that in this mode, :ref:`encryption_parameters
	// <envoy_v3_api_field_extensions.quic.connection_id_generator.quic_lb.v3.Config.encryption_parameters>`
	// is still required because it contains “configuration_version“, which is still
	// needed. “encryption_key“ can be set to “inline_string: '0000000000000000'“.
	unencrypted_mode?: bool
}
