package v3

// Generic UDP socket configuration.
#UdpSocketConfig: {
	"@type": "type.googleapis.com/envoy.config.core.v3.UdpSocketConfig"
	// The maximum size of received UDP datagrams. Using a larger size will cause Envoy to allocate
	// more memory per socket. Received datagrams above this size will be dropped. If not set
	// defaults to 1500 bytes.
	max_rx_datagram_size?: uint64
	// Configures whether Generic Receive Offload (GRO)
	// <https://en.wikipedia.org/wiki/Large_receive_offload>_ is preferred when reading from the
	// UDP socket. The default is context dependent and is documented where UdpSocketConfig is used.
	// This option affects performance but not functionality. If GRO is not supported by the operating
	// system, non-GRO receive will be used.
	prefer_gro?: bool
}
