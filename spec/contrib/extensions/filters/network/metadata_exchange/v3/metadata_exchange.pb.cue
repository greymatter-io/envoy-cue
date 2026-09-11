package v3

// [#protodoc-title: MetadataExchange protocol match and data transfer]
// MetadataExchange protocol match and data transfer
#MetadataExchange: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.metadata_exchange.v3.MetadataExchange"
	// Protocol that Alpn should support on the server.
	// [#comment:TODO(GargNupur): Make it a list.]
	protocol?: string
	// If true, will attempt to use WDS in case the prefix peer metadata is not available.
	enable_discovery?: bool
	// Additional labels to be added to the peer metadata to help your understand the traffic.
	// e.g. “role“, “location“ etc.
	additional_labels?: [...string]
}
