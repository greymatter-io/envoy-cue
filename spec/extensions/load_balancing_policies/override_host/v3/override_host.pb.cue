package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/metadata/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/cluster/v3"
)

// Configuration for the Override Host Load Balancing policy.
//
// This policy allows endpoint picking to be implemented in downstream HTTP filters. For example an ext_proc RPC to a service
// that implements k8s proposal for AI gateway inferences extensions
// https://github.com/kubernetes-sigs/gateway-api-inference-extension/tree/main/docs/proposals/004-endpoint-picker-protocol
// can provide hosts for serving a request using Override Host load balancing policy.
//
// This policy extracts selected override hosts from a list of “OverrideHostSource“ (request headers, metadata, etc.).
//
// The override host source must specify at least one host in “IP:Port“ format or multiple hosts in “IP:Port,IP:Port,...“
// format. For example “10.0.0.5:8080“ or “[2600:4040:5204::1574:24ae]:80“. The IPv6 address is enclosed in square brackets.
//
// For specific example, to support k8s gateway inference extensions, which uses the “x-gateway-destination-endpoint“
// header or metadata value under the "envoy.lb" key for selected hosts, the Override Host load balancing policy should be
// configured in the following way:
//
// .. code-block:: yaml
//
//	override_host_sources:
//	- header: "x-gateway-destination-endpoint"
//	- metadata:
//	    key: "envoy.lb"
//	    path:
//	    - key: "x-gateway-destination-endpoint"
//
// If no valid host in the override host list, then the specified fallback load balancing policy is used. This allows load
// balancing to degrade to a a built in policy (i.e. Round Robin) in case external endpoint picker fails.
//
// In addition to specifying “override_host_sources“, the policy can be configured to inform downstream filters
// of the selected endpoint through dynamic metadata or response headers through “selected_endpoint_key“:
//
// .. code-block:: yaml
//
//	override_host_sources:
//	- metadata:
//	    key: "envoy.lb"
//	    path:
//	    - key: "x-gateway-destination-endpoint"
//	selected_host_key:
//	  key: "envoy.lb"
//	  path:
//	  - key: "x-gateway-destination-endpoint-served"
//
// See the :ref:`load balancing architecture
// overview<arch_overview_load_balancing_types>` for more information.
#OverrideHost: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.override_host.v3.OverrideHost"
	// A list of sources to get host addresses from. The host sources are searched in the order
	// specified. The request is forwarded to the first address and subsequent addresses are used
	// for request retries or hedging.
	// Note that if an overridden host address is not present in the current endpoint set, it is
	// skipped and the next found address is used. If there are not enough overridden addresses to
	// satisfy all retry attempts the fallback load balancing policy is used to pick a host.
	override_host_sources?: [...#OverrideHost_OverrideHostSource]
	// The metadata key to populate with the selected host address. This is optional and
	// may be used to inform downstream filters of the host address selected by load balancing policy.
	selected_host_key?: v3.#MetadataKey
	// The child LB policy to use in case neither header nor metadata with selected
	// hosts is present.
	fallback_policy?: v31.#LoadBalancingPolicy
}

#OverrideHost_OverrideHostSource: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.override_host.v3.OverrideHost_OverrideHostSource"
	// The header to get the override host addresses.
	//
	// Only one of the header or metadata field could be set.
	header?: string
	// The metadata key to get the override host addresses from the request dynamic metadata. If
	// set this field then it will take precedence over the header field.
	//
	// Only one of the header or metadata field could be set.
	metadata?: v3.#MetadataKey
}
