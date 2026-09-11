package v3

// Serialization format for metrics produced to Kafka.
#SerializationFormat: "JSON" | "PROTOBUF"

SerializationFormat_JSON:     "JSON"
SerializationFormat_PROTOBUF: "PROTOBUF"

// Configuration for the Kafka stats sink. Metrics are serialized and
// produced to a Kafka topic using librdkafka.
// [#next-free-field: 9]
#KafkaStatsSinkConfig: {
	"@type": "type.googleapis.com/envoy.extensions.stat_sinks.kafka.v3.KafkaStatsSinkConfig"
	// Comma-separated list of Kafka broker addresses in host:port format.
	// At least one broker must be specified.
	broker_list?: string
	// Kafka topic to produce metrics to.
	topic?: string
	// Number of metrics to batch into a single Kafka message. If 0 or unset,
	// all metrics from a single flush are sent in one message. Setting a batch
	// size helps control message sizes when there are many metrics.
	batch_size?: uint32
	// If true, counters are reported as the delta since last flush rather than
	// the absolute cumulative value. Defaults to false.
	report_counters_as_deltas?: bool
	// If true, tag-extracted metric names are used and tags are emitted as
	// separate labels/JSON fields. If false, the full metric name (including tag
	// values) is used. Defaults to true.
	emit_tags_as_labels?: bool
	// Additional librdkafka producer configuration properties as key-value pairs.
	// These are passed directly to librdkafka and can be used to configure
	// compression (“compression.type“), authentication (“security.protocol“,
	// “sasl.mechanism“, etc.), batching (“batch.num.messages“), and more.
	// See https://github.com/confluentinc/librdkafka/blob/master/CONFIGURATION.md
	producer_config?: [string]: string
	// Maximum time in milliseconds to buffer messages before forcing a produce.
	// Maps to librdkafka's “linger.ms“. If not set, defaults to 500ms.
	buffer_flush_timeout_ms?: uint32
	// Serialization format for metric messages produced to Kafka.
	// Defaults to JSON.
	format?: #SerializationFormat
}
