package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Filter-level configuration for the filter chain filter. This filter acts as a wrapper
// that applies a configurable chain of HTTP filters to incoming requests.
//
// When a request arrives the filter collects all active filter chains in order from least
// to most specific: “default_filter_chain“ first, then any per-route chains ordered from
// the outermost scope (e.g. route configuration level) to the innermost scope (route level).
// Each filter in a less-specific chain is applied **unless** a more-specific chain contains
// a filter with the same “name“.
//
// The final set of filters is applied in order from least to most specific, so that the
// least-specific filter runs first and the most-specific filter runs last. This allows
// more specific filters to override the behavior of less specific ones.
//
// If no chains are found at all the filter passes through without modifying the request.
#FilterChainConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.filter_chain.v3.FilterChainConfig"
	// Default filter chain to apply when processing every request.
	//
	// This field is optional. When omitted the filter still participates in per-route
	// override resolution.
	default_filter_chain?: #FilterChain
}

// Per-route configuration for the filter chain filter. This allows different filter chains
// to be applied on different routes.
//
// .. note::
//
//	Only the initial route match is considered for filter chain selection. Subsequent
//	internal route refreshes do not affect the filter chain applied to the request.
//
// When multiple per-route configs exist along the route hierarchy (e.g. one at virtual-host
// level and one at route level) the same merge rules apply iteratively from least specific
// to most specific, so the most specific definition of any named filter always wins.
#FilterChainConfigPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.filter_chain.v3.FilterChainConfigPerRoute"
	// Filter chain to apply on this route. Must contain at least one filter.
	//
	// .. note::
	//
	//	Not all HTTP filters are compatible to be used within this route level filter chain
	//	for now.
	filter_chain?: #FilterChain
}

// A filter chain is a list of HTTP filters that are applied in order.
// This message is used to define a reusable chain of filters.
#FilterChain: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.filter_chain.v3.FilterChain"
	// A list of HTTP filter configurations to be applied in order.
	// Each filter in the chain will process the request/response in sequence.
	// At least one filter must be specified.
	//
	// .. warning::
	//
	//	Please do not configure the ``filter_chain`` filter itself or ``composite`` filter
	//	within this list recursively to avoid undefined behavior.
	//
	// .. note::
	//
	//	It is possible to configure ``terminal`` filters (filters that do not expect next filter
	//	in the chain, e.g., ``envoy.filters.http.router``) in the middle of the chain. However,
	//	use it with caution to avoid unexpected behavior.
	//
	// [#extension-category: envoy.filters.http]
	filters?: [...v3.#TypedExtensionConfig]
}
