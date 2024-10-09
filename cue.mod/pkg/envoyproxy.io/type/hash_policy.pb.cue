package type

// Specifies the hash policy
#HashPolicy: {
	"@type":    "type.googleapis.com/envoy.type.HashPolicy"
	source_ip?: #HashPolicy_SourceIp
}

// The source IP will be used to compute the hash used by hash-based load balancing
// algorithms.
#HashPolicy_SourceIp: {
	"@type": "type.googleapis.com/envoy.type.HashPolicy_SourceIp"
}
