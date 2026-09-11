package v3

// Peer metadata provider filter. This filter encapsulates the discovery of the
// peer telemetry attributes for consumption by the telemetry filters.
// [#next-free-field: 7]
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.peer_metadata.v3.Config"
	// The order of the derivation of the downstream peer metadata, in the precedence order.
	// First successful lookup wins.
	downstream_discovery?: [...#Config_DiscoveryMethod]
	// The order of the derivation of the upstream peer metadata, in the precedence order.
	// First successful lookup wins.
	upstream_discovery?: [...#Config_DiscoveryMethod]
	// Downstream injection of the metadata via a response header.
	downstream_propagation?: [...#Config_PropagationMethod]
	// Upstream injection of the metadata via a request header.
	upstream_propagation?: [...#Config_PropagationMethod]
	// True to enable sharing with the upstream.
	shared_with_upstream?: bool
	// Additional labels to be added to the peer metadata to help your understand the traffic.
	// e.g. “role“, “location“ etc.
	additional_labels?: [...string]
}

// This method uses “baggage“ header encoding. Only used for HTTP CONNECT tunnels.
#Config_Baggage: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.peer_metadata.v3.Config_Baggage"
}

// This method uses the workload metadata xDS. Requires that the bootstrap extension is enabled.
// For downstream discovery, the remote address is the lookup key in xDS.
// For upstream discovery:
//
//   - If the upstream host address is an IP, this IP is used as the lookup key;
//   - If the upstream host address is internal, uses the
//     “filter_metadata.tunnel.destination“ dynamic metadata value as the lookup key.
#Config_WorkloadDiscovery: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.peer_metadata.v3.Config_WorkloadDiscovery"
}

// This method uses Istio HTTP metadata exchange headers, e.g. “x-envoy-peer-metadata“. Removes these headers if found.
#Config_IstioHeaders: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.peer_metadata.v3.Config_IstioHeaders"
	// Strip “x-envoy-peer-metadata“ and “x-envoy-peer-metadata-id“ headers on HTTP requests to services outside the mesh.
	// Detects upstream clusters with “istio“ and “external“ filter metadata fields
	skip_external_clusters?: bool
}

// This method extracts peer metadata from the upstream filter state if it's available.
//
// Upstream filter state could be populated by multiple means in general, but in practice the
// intention here is that upstream PeerMetadata filter will populate the filter state with peer
// details extracted from the baggage header sent in response.
//
// Naturally this metadata discovery method only makes sense for upstream peer metadata discovery.
#Config_UpstreamFilterState: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.peer_metadata.v3.Config_UpstreamFilterState"
	// Upstream filter state key that will be used to store peer metadata.
	peer_metadata_key?: string
}

// An exhaustive list of the derivation methods.
#Config_DiscoveryMethod: {
	"@type":                "type.googleapis.com/envoy.extensions.filters.http.peer_metadata.v3.Config_DiscoveryMethod"
	baggage?:               #Config_Baggage
	workload_discovery?:    #Config_WorkloadDiscovery
	istio_headers?:         #Config_IstioHeaders
	upstream_filter_state?: #Config_UpstreamFilterState
}

// An exhaustive list of the metadata propagation methods.
#Config_PropagationMethod: {
	"@type":        "type.googleapis.com/envoy.extensions.filters.http.peer_metadata.v3.Config_PropagationMethod"
	istio_headers?: #Config_IstioHeaders
	baggage?:       #Config_Baggage
}
