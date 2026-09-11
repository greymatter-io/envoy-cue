package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/deps/cncf/xds/go/xds/type/matcher/v3"
)

#ClusterAction: {
	"@type": "type.googleapis.com/envoy.extensions.router.cluster_specifiers.matcher.v3.ClusterAction"
	// Indicates the upstream cluster to which the request should be routed
	// to.
	cluster?: string
}

#MatcherClusterSpecifier: {
	"@type": "type.googleapis.com/envoy.extensions.router.cluster_specifiers.matcher.v3.MatcherClusterSpecifier"
	// The matcher for cluster selection after the route has been selected. This is used when the
	// route has multiple clusters (like multiple clusters for different users) and the matcher
	// is used to select the cluster to use for the request.
	//
	// The match tree to use for grouping incoming requests into buckets.
	//
	// Example:
	//
	// .. validated-code-block:: yaml
	//
	//	:type-name: xds.type.matcher.v3.Matcher
	//
	//	matcher_list:
	//	  matchers:
	//	  - predicate:
	//	      single_predicate:
	//	        input:
	//	          typed_config:
	//	            '@type': type.googleapis.com/envoy.type.matcher.v3.HttpRequestHeaderMatchInput
	//	            header_name: env
	//	        value_match:
	//	          exact: staging
	//	    on_match:
	//	      action:
	//	        typed_config:
	//	          '@type': type.googleapis.com/envoy.extensions.router.cluster_specifiers.matcher.v3.ClusterAction
	//	          cluster: "staging-cluster"
	//
	//	  - predicate:
	//	      single_predicate:
	//	        input:
	//	          typed_config:
	//	            '@type': type.googleapis.com/envoy.type.matcher.v3.HttpRequestHeaderMatchInput
	//	            header_name: env
	//	        value_match:
	//	          exact: prod
	//	    on_match:
	//	      action:
	//	        typed_config:
	//	          '@type': type.googleapis.com/envoy.extensions.router.cluster_specifiers.matcher.v3.ClusterAction
	//	          cluster: "prod-cluster"
	//
	//	# Catch-all with a default cluster.
	//	on_no_match:
	//	  action:
	//	    typed_config:
	//	      '@type': type.googleapis.com/envoy.extensions.router.cluster_specifiers.matcher.v3.ClusterAction
	//	      cluster: "default-cluster"
	cluster_matcher?: v3.#Matcher
}
