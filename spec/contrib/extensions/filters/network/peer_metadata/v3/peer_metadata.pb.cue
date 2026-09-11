package v3

// Configuration for the downstream network filter installed in the
// connect_originate or inner_connect_originate filter chains. It extracts
// peer metadata from TCP Proxy filter state (baggage header from HBONE CONNECT
// response) and injects it as a data preamble to be consumed by the upstream
// filter.
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.peer_metadata.v3.Config"
	// What filter state to use to save the baggage value that encodes the proxy
	// workload.
	//
	// The upstream filter that will populate the baggage header in the HBONE
	// request should be configured to use the same key.
	//
	// Why share baggage value via filter state instead of to configure upstream
	// filter to use the baggage key value directly?
	//
	// ztunnel and waypoint have to be aware of the baggage header format,
	// because they should be able to parse baggage headers to extract the
	// metadata and report the metrics. However, pilot does not need to be aware
	// of the baggage encoding yet.
	//
	// If instead of using custom filter to generate baggage header value we just
	// let pilot generate it, it would spread the logic for generating baggage to
	// the pilot as well. While not a big deal, if there is no clear reason to do
	// it, let's not duplicate the implementation of baggage logic in pilot and
	// just re-use the logic we already have in Envoy.
	baggage_key?: string
}

// Configuration for the upstream network filter installed in service clusters
// that communicate over HBONE. It consumes and removes the metadata preamble
// injected by the downstream filter and populates filter state for use by
// Istio telemetry filters.
#UpstreamConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.peer_metadata.v3.UpstreamConfig"
}
