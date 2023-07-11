package v3

// Validates a CDS config, and ensures that the number of clusters is above the
// set threshold.
#MinimumClustersValidator: {
	"@type": "type.googleapis.com/envoy.extensions.config.validators.minimum_clusters.v3.MinimumClustersValidator"
	// The minimal clusters threshold. Any CDS config update leading to less than
	// this number will be rejected.
	// Default value is 0.
	min_clusters_num?: uint32
}
