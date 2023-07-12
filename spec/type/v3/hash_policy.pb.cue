package v3

// Specifies the hash policy
#HashPolicy: {
	"@type":       "type.googleapis.com/envoy.type.v3.HashPolicy"
	source_ip?:    #HashPolicy_SourceIp
	filter_state?: #HashPolicy_FilterState
}

// The source IP will be used to compute the hash used by hash-based load balancing
// algorithms.
#HashPolicy_SourceIp: {
	"@type": "type.googleapis.com/envoy.type.v3.HashPolicy_SourceIp"
}

// An Object in the :ref:`filterState <arch_overview_data_sharing_between_filters>` will be used
// to compute the hash used by hash-based load balancing algorithms.
#HashPolicy_FilterState: {
	"@type": "type.googleapis.com/envoy.type.v3.HashPolicy_FilterState"
	// The name of the Object in the filterState, which is an Envoy::Hashable object. If there is no
	// data associated with the key, or the stored object is not Envoy::Hashable, no hash will be
	// produced.
	key?: string
}
