package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Configuration of on-demand CDS.
#OnDemandCds: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.on_demand.v3.OnDemandCds"
	// A configuration source for the service that will be used for
	// on-demand cluster discovery.
	source?: v3.#ConfigSource
	// xdstp:// resource locator for on-demand cluster collection.
	resources_locator?: string
	// The timeout for on demand cluster lookup. If not set, defaults to 5 seconds.
	timeout?: string
}

// On Demand Discovery filter config.
#OnDemand: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.on_demand.v3.OnDemand"
	// An optional configuration for on-demand cluster discovery
	// service. If not specified, the on-demand cluster discovery will
	// be disabled. When it's specified, the filter will pause the
	// request to an unknown cluster and will begin a cluster discovery
	// process. When the discovery is finished (successfully or not), the
	// request will be resumed for further processing.
	odcds?: #OnDemandCds
}

// Per-route configuration for On Demand Discovery.
#PerRouteConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.on_demand.v3.PerRouteConfig"
	// An optional configuration for on-demand cluster discovery
	// service. If not specified, the on-demand cluster discovery will
	// be disabled. When it's specified, the filter will pause the
	// request to an unknown cluster and will begin a cluster discovery
	// process. When the discovery is finished (successfully or not), the
	// request will be resumed for further processing.
	odcds?: #OnDemandCds
}
