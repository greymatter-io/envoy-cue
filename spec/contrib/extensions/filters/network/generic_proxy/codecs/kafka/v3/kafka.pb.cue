package v3

// Configuration for Kafka codec. This codec gives the generic proxy the ability to proxy
// Kafka traffic. But note any route configuration for Kafka traffic is not supported yet.
// The generic proxy can only used to generate logs or metrics for Kafka traffic but cannot
// do matching or routing.
//
// .. note::
//
//	The codec can currently only be used in the sidecar mode. And to ensure the codec works
//	properly, please make sure the following conditions are met:
//
//	1. The generic proxy must be configured with a wildcard route that matches all traffic.
//	2. The target cluster must be configured as a original destination cluster.
//	3. The :ref:`bind_upstream_connection
//	   <envoy_v3_api_field_extensions.filters.network.generic_proxy.router.v3.Router.bind_upstream_connection>`
//	   of generic proxy router must be set to true to ensure same upstream connection is used
//	   for all traffic from same downstream connection.
#KafkaCodecConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.codecs.kafka.v3.KafkaCodecConfig"
}
