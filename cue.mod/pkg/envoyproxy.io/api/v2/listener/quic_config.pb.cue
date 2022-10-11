package listener

// Configuration specific to the QUIC protocol.
// Next id: 4
#QuicProtocolOptions: {
	"@type": "type.googleapis.com/envoy.api.v2.listener.QuicProtocolOptions"
	// Maximum number of streams that the client can negotiate per connection. 100
	// if not specified.
	max_concurrent_streams?: uint32
	// Maximum number of milliseconds that connection will be alive when there is
	// no network activity. 300000ms if not specified.
	idle_timeout?: string
	// Connection timeout in milliseconds before the crypto handshake is finished.
	// 20000ms if not specified.
	crypto_handshake_timeout?: string
}
