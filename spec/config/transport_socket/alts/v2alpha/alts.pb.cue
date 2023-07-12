package v2alpha

// Configuration for ALTS transport socket. This provides Google's ALTS protocol to Envoy.
// https://cloud.google.com/security/encryption-in-transit/application-layer-transport-security/
#Alts: {
	"@type": "type.googleapis.com/envoy.config.transport_socket.alts.v2alpha.Alts"
	// The location of a handshaker service, this is usually 169.254.169.254:8080
	// on GCE.
	handshaker_service?: string
	// The acceptable service accounts from peer, peers not in the list will be rejected in the
	// handshake validation step. If empty, no validation will be performed.
	peer_service_accounts?: [...string]
}
