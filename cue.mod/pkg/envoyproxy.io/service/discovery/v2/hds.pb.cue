package v2

import (
	core "envoyproxy.io/api/v2/core"
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
	endpoint "envoyproxy.io/api/v2/endpoint"
)

// Different Envoy instances may have different capabilities (e.g. Redis)
// and/or have ports enabled for different protocols.
#Capability_Protocol: "HTTP" | "TCP" | "REDIS"

Capability_Protocol_HTTP:  "HTTP"
Capability_Protocol_TCP:   "TCP"
Capability_Protocol_REDIS: "REDIS"

// Defines supported protocols etc, so the management server can assign proper
// endpoints to healthcheck.
#Capability: {
	"@type": "type.googleapis.com/envoy.service.discovery.v2.Capability"
	health_check_protocols?: [...#Capability_Protocol]
}

#HealthCheckRequest: {
	"@type":     "type.googleapis.com/envoy.service.discovery.v2.HealthCheckRequest"
	node?:       core.#Node
	capability?: #Capability
}

#EndpointHealth: {
	"@type":        "type.googleapis.com/envoy.service.discovery.v2.EndpointHealth"
	endpoint?:      endpoint.#Endpoint
	health_status?: core.#HealthStatus
}

#EndpointHealthResponse: {
	"@type": "type.googleapis.com/envoy.service.discovery.v2.EndpointHealthResponse"
	endpoints_health?: [...#EndpointHealth]
}

#HealthCheckRequestOrEndpointHealthResponse: {
	"@type":                   "type.googleapis.com/envoy.service.discovery.v2.HealthCheckRequestOrEndpointHealthResponse"
	health_check_request?:     #HealthCheckRequest
	endpoint_health_response?: #EndpointHealthResponse
}

#LocalityEndpoints: {
	"@type":   "type.googleapis.com/envoy.service.discovery.v2.LocalityEndpoints"
	locality?: core.#Locality
	endpoints?: [...endpoint.#Endpoint]
}

// The cluster name and locality is provided to Envoy for the endpoints that it
// health checks to support statistics reporting, logging and debugging by the
// Envoy instance (outside of HDS). For maximum usefulness, it should match the
// same cluster structure as that provided by EDS.
#ClusterHealthCheck: {
	"@type":       "type.googleapis.com/envoy.service.discovery.v2.ClusterHealthCheck"
	cluster_name?: string
	health_checks?: [...core.#HealthCheck]
	locality_endpoints?: [...#LocalityEndpoints]
}

#HealthCheckSpecifier: {
	"@type": "type.googleapis.com/envoy.service.discovery.v2.HealthCheckSpecifier"
	cluster_health_checks?: [...#ClusterHealthCheck]
	// The default is 1 second.
	interval?: durationpb.#Duration
}
