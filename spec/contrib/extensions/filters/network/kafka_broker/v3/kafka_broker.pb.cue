package v3

// [#protodoc-title: Kafka Broker]
// Kafka Broker :ref:`configuration overview <config_network_filters_kafka_broker>`.
// [#extension: envoy.filters.network.kafka_broker]
// [#next-free-field: 6]
#KafkaBroker: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.kafka_broker.v3.KafkaBroker"
	// The prefix to use when emitting :ref:`statistics <config_network_filters_kafka_broker_stats>`.
	stat_prefix?: string
	// Set to true if broker filter should attempt to serialize the received responses from the
	// upstream broker instead of passing received bytes as is.
	// Disabled by default.
	force_response_rewrite?: bool
	// Broker address rewrite rules that match by broker ID.
	id_based_broker_address_rewrite_spec?: #IdBasedBrokerRewriteSpec
	// Optional list of allowed Kafka API keys. Only requests with provided API keys will be
	// routed, otherwise the connection will be closed. No effect if empty.
	api_keys_allowed?: [...uint32]
	// Optional list of denied Kafka API keys. Requests with API keys matching this list will have
	// the connection closed. No effect if empty.
	api_keys_denied?: [...uint32]
}

// Collection of rules matching by broker ID.
#IdBasedBrokerRewriteSpec: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.kafka_broker.v3.IdBasedBrokerRewriteSpec"
	rules?: [...#IdBasedBrokerRewriteRule]
}

// Defines a rule to rewrite broker address data.
#IdBasedBrokerRewriteRule: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.kafka_broker.v3.IdBasedBrokerRewriteRule"
	// Broker ID to match.
	id?: uint32
	// The host value to use (resembling the host part of Kafka's advertised.listeners).
	// The value should point to the Envoy (not Kafka) listener, so that all client traffic goes
	// through Envoy.
	host?: string
	// The port value to use (resembling the port part of Kafka's advertised.listeners).
	// The value should point to the Envoy (not Kafka) listener, so that all client traffic goes
	// through Envoy.
	port?: uint32
}
