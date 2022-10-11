package v2

import (
	core "envoyproxy.io/api/v2/core"
	matcher "envoyproxy.io/type/matcher"
	v2alpha "envoyproxy.io/admin/v2alpha"
)

// Status of a config.
#ConfigStatus: "UNKNOWN" | "SYNCED" | "NOT_SENT" | "STALE" | "ERROR"

ConfigStatus_UNKNOWN:  "UNKNOWN"
ConfigStatus_SYNCED:   "SYNCED"
ConfigStatus_NOT_SENT: "NOT_SENT"
ConfigStatus_STALE:    "STALE"
ConfigStatus_ERROR:    "ERROR"

// Request for client status of clients identified by a list of NodeMatchers.
#ClientStatusRequest: {
	"@type": "type.googleapis.com/envoy.service.status.v2.ClientStatusRequest"
	// Management server can use these match criteria to identify clients.
	// The match follows OR semantics.
	node_matchers?: [...matcher.#NodeMatcher]
}

// Detailed config (per xDS) with status.
// [#next-free-field: 6]
#PerXdsConfig: {
	"@type":              "type.googleapis.com/envoy.service.status.v2.PerXdsConfig"
	status?:              #ConfigStatus
	listener_config?:     v2alpha.#ListenersConfigDump
	cluster_config?:      v2alpha.#ClustersConfigDump
	route_config?:        v2alpha.#RoutesConfigDump
	scoped_route_config?: v2alpha.#ScopedRoutesConfigDump
}

// All xds configs for a particular client.
#ClientConfig: {
	"@type": "type.googleapis.com/envoy.service.status.v2.ClientConfig"
	// Node for a particular client.
	node?: core.#Node
	xds_config?: [...#PerXdsConfig]
}

#ClientStatusResponse: {
	"@type": "type.googleapis.com/envoy.service.status.v2.ClientStatusResponse"
	// Client configs for the clients specified in the ClientStatusRequest.
	config?: [...#ClientConfig]
}

// ClientStatusDiscoveryServiceClient is the client API for ClientStatusDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#ClientStatusDiscoveryServiceClient: _

#ClientStatusDiscoveryService_StreamClientStatusClient: _

// ClientStatusDiscoveryServiceServer is the server API for ClientStatusDiscoveryService service.
#ClientStatusDiscoveryServiceServer: _

// UnimplementedClientStatusDiscoveryServiceServer can be embedded to have forward compatible implementations.
#UnimplementedClientStatusDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.status.v2.UnimplementedClientStatusDiscoveryServiceServer"
}

#ClientStatusDiscoveryService_StreamClientStatusServer: _
