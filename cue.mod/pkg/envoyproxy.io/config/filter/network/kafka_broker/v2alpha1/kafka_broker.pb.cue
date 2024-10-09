package v2alpha1

#KafkaBroker: {
	"@type": "type.googleapis.com/envoy.config.filter.network.kafka_broker.v2alpha1.KafkaBroker"
	// The prefix to use when emitting :ref:`statistics <config_network_filters_kafka_broker_stats>`.
	stat_prefix?: string
	// Set to true if broker filter should attempt to serialize the received responses from the
	// upstream broker instead of passing received bytes as is.
	// Disabled by default.
	force_response_rewrite?: bool
	// Broker address rewrite rules that match by broker ID.
	id_based_broker_address_rewrite_spec?: #IdBasedBrokerRewriteSpec
}

// Collection of rules matching by broker ID.
#IdBasedBrokerRewriteSpec: {
	"@type": "type.googleapis.com/envoy.config.filter.network.kafka_broker.v2alpha1.IdBasedBrokerRewriteSpec"
	rules?: [...#IdBasedBrokerRewriteRule]
}

// Defines a rule to rewrite broker address data.
#IdBasedBrokerRewriteRule: {
	"@type": "type.googleapis.com/envoy.config.filter.network.kafka_broker.v2alpha1.IdBasedBrokerRewriteRule"
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
