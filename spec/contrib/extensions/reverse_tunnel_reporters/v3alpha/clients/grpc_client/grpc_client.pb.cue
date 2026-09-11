package grpc_client

// Configuration for gRPC push-based connection event client.
// Actively pushes connection events to a cluster using grpc using some internal timing.
// [#next-free-field: 7]
#GrpcClientConfig: {
	"@type": "type.googleapis.com/envoy.extensions.reverse_tunnel_reporters.v3alpha.clients.grpc_client.GrpcClientConfig"
	// Stat prefix for this client's metrics.
	stat_prefix?: string
	// Name of the cluster to send gRPC requests to.
	// It must be present in the config otherwise the setup will throw error in the onServerInitialized.
	cluster?: string
	// Default interval between sending batched connection events.
	// Default is 5s.
	default_send_interval?: string
	// Interval between connection retry attempts to the gRPC service.
	// Connect timeouts are provided at the cluster level and will be handled by the http/2 client.
	// How much time to wait after a failed connect before retrying. Default is 5s.
	connect_retry_interval?: string
	// Maximum number of retry attempts for failed gRPC sends.
	// Basically the cluster will have default_send_interval * max_retries time to respond.
	// Default is 5. After this we will disconnect and try to connect again.
	max_retries?: uint32
	// Maximum events to buffer at any given time
	// Default is 1,000,000.
	max_buffer_count?: uint32
}
