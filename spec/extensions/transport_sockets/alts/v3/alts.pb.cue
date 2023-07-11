package v3

// Configuration for ALTS transport socket. This provides Google's ALTS protocol to Envoy.
// Store the peer identity in dynamic metadata, namespace is "envoy.transport_socket.peer_information", key is "peer_identity".
// https://cloud.google.com/security/encryption-in-transit/application-layer-transport-security/
#Alts: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.alts.v3.Alts"
	// The location of a handshaker service, this is usually 169.254.169.254:8080
	// on GCE.
	handshaker_service?: string
	// The acceptable service accounts from peer, peers not in the list will be rejected in the
	// handshake validation step. If empty, no validation will be performed.
	peer_service_accounts?: [...string]
}
