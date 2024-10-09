package v3

import (
	anypb "envoyproxy.io/deps/protobuf/types/known/anypb"
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
	v3 "envoyproxy.io/config/core/v3"
	v31 "envoyproxy.io/config/route/v3"
)

// Configuration for the route match action.
// [#next-free-field: 8]
#RouteAction: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.action.v3.RouteAction"
	// The name of the route action. This should be unique across all route actions.
	name?: string
	// Indicates the upstream cluster to which the request should be routed.
	cluster?: string
	// [#not-implemented-hide:]
	// Multiple upstream clusters can be specified for a given route. The request is routed to one
	// of the upstream clusters based on weights assigned to each cluster.
	// Currently ClusterWeight only supports the name and weight fields.
	weighted_clusters?: v31.#WeightedCluster
	// Route metadata.
	metadata?: v3.#Metadata
	// Route level config for L7 generic filters. The key should be the related :ref:`extension name
	// <envoy_v3_api_field_config.core.v3.TypedExtensionConfig.name>` in the :ref:`generic filters
	// <envoy_v3_api_field_extensions.filters.network.generic_proxy.v3.GenericProxy.filters>`.
	per_filter_config?: [string]: anypb.#Any
	// Specifies the upstream timeout for the route. If not specified, the default is 15s. This
	// spans between the point at which the entire downstream request (i.e. end-of-stream) has been
	// processed and when the upstream response has been completely processed. A value of 0 will
	// disable the route's timeout.
	timeout?: durationpb.#Duration
	// Specifies the retry policy for the route. If not specified, then no retries will be performed.
	//
	// .. note::
	//
	//	Only simplest retry policy is supported and only ``num_retries`` field is used for generic
	//	proxy. The default value for ``num_retries`` is 1 means that the request will be tried once
	//	and no additional retries will be performed.
	retry_policy?: v3.#RetryPolicy
}
