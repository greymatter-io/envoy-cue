package v3alpha

#KafkaMesh_ConsumerProxyMode: "StatefulConsumerProxy"

KafkaMesh_ConsumerProxyMode_StatefulConsumerProxy: "StatefulConsumerProxy"

// [#next-free-field: 6]
#KafkaMesh: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.kafka_mesh.v3alpha.KafkaMesh"
	// Envoy's host that's advertised to clients.
	// Has the same meaning as corresponding Kafka broker properties.
	// Usually equal to filter chain's listener config, but needs to be reachable by clients
	// (so 0.0.0.0 will not work).
	advertised_host?: string
	// Envoy's port that's advertised to clients.
	advertised_port?: int32
	// Upstream clusters this filter will connect to.
	upstream_clusters?: [...#KafkaClusterDefinition]
	// Rules that will decide which cluster gets which request.
	forwarding_rules?: [...#ForwardingRule]
	// How the consumer proxying should behave - this relates mostly to Fetch request handling.
	consumer_proxy_mode?: #KafkaMesh_ConsumerProxyMode
}

// [#next-free-field: 6]
#KafkaClusterDefinition: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.kafka_mesh.v3alpha.KafkaClusterDefinition"
	// Cluster name.
	cluster_name?: string
	// Kafka cluster address.
	bootstrap_servers?: string
	// Default number of partitions present in this cluster.
	// This is especially important for clients that do not specify partition in their payloads and depend on this value for hashing.
	// The same number of partitions is going to be used by upstream-pointing Kafka consumers for consumer proxying scenarios.
	partition_count?: int32
	// Custom configuration passed to Kafka producer.
	producer_config?: [string]: string
	// Custom configuration passed to Kafka consumer.
	consumer_config?: [string]: string
}

#ForwardingRule: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.kafka_mesh.v3alpha.ForwardingRule"
	// Cluster name.
	target_cluster?: string
	// Intended place for future types of forwarding rules.
	topic_prefix?: string
}
