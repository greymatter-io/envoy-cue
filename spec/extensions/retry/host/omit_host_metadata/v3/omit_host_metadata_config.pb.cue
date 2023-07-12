package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// A retry host predicate that can be used to reject a host based on
// predefined metadata match criteria.
// [#extension: envoy.retry_host_predicates.omit_host_metadata]
#OmitHostMetadataConfig: {
	"@type": "type.googleapis.com/envoy.extensions.retry.host.omit_host_metadata.v3.OmitHostMetadataConfig"
	// Retry host predicate metadata match criteria. The hosts in
	// the upstream cluster with matching metadata will be omitted while
	// attempting a retry of a failed request. The metadata should be specified
	// under the ``envoy.lb`` key.
	metadata_match?: v3.#Metadata
}
