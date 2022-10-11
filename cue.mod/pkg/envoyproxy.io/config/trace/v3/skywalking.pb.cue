package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Configuration for the SkyWalking tracer. Please note that if SkyWalking tracer is used as the
// provider of http tracer, then
// :ref:`start_child_span <envoy_v3_api_field_extensions.filters.http.router.v3.Router.start_child_span>`
// in the router must be set to true to get the correct topology and tracing data. Moreover, SkyWalking
// Tracer does not support SkyWalking extension header (``sw8-x``) temporarily.
// [#extension: envoy.tracers.skywalking]
#SkyWalkingConfig: {
	"@type": "type.googleapis.com/envoy.config.trace.v3.SkyWalkingConfig"
	// SkyWalking collector service.
	grpc_service?:  v3.#GrpcService
	client_config?: #ClientConfig
}

// Client config for SkyWalking tracer.
#ClientConfig: {
	"@type": "type.googleapis.com/envoy.config.trace.v3.ClientConfig"
	// Service name for SkyWalking tracer. If this field is empty, then local service cluster name
	// that configured by :ref:`Bootstrap node <envoy_v3_api_field_config.bootstrap.v3.Bootstrap.node>`
	// message's :ref:`cluster <envoy_v3_api_field_config.core.v3.Node.cluster>` field or command line
	// option :option:`--service-cluster` will be used. If both this field and local service cluster
	// name are empty, ``EnvoyProxy`` is used as the service name by default.
	service_name?: string
	// Service instance name for SkyWalking tracer. If this field is empty, then local service node
	// that configured by :ref:`Bootstrap node <envoy_v3_api_field_config.bootstrap.v3.Bootstrap.node>`
	// message's :ref:`id <envoy_v3_api_field_config.core.v3.Node.id>` field or command line  option
	// :option:`--service-node` will be used. If both this field and local service node are empty,
	// ``EnvoyProxy`` is used as the instance name by default.
	instance_name?: string
	// Inline authentication token string.
	backend_token?: string
	// Envoy caches the segment in memory when the SkyWalking backend service is temporarily unavailable.
	// This field specifies the maximum number of segments that can be cached. If not specified, the
	// default is 1024.
	max_cache_size?: uint32
}
