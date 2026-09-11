package v3alpha

// The fallback policy if any error occurs.
// The default policy is None.
#Dlb_FallbackPolicy: "None" | "NopConnectionBalance" | "ExactConnectionBalance"

Dlb_FallbackPolicy_None:                   "None"
Dlb_FallbackPolicy_NopConnectionBalance:   "NopConnectionBalance"
Dlb_FallbackPolicy_ExactConnectionBalance: "ExactConnectionBalance"

// The Dlb is a hardware managed system of queues and arbiters connecting producers and consumers. It is a PCIE device
// in the CPU package. It interacts with software running on cores and potentially other devices. The Dlb implements the
// following balancing features:
//
// -  Lock-free multi-producer/multi-consumer operation.
// -  Multiple priorities for varying traffic types.
// -  Various distribution schemes.
//
// Dlb connection balancer uses Dlb hardware to balance connections, and can significantly reduce latency.
//
// As the Dlb connection balancer provides assistance from dedicated Dlb hardware, it can be used for a proxy with a large number of connections
// (e.g., a gateway).
#Dlb: {
	"@type": "type.googleapis.com/envoy.extensions.network.connection_balance.dlb.v3alpha.Dlb"
	// The ID of the Dlb hardware, start from 0.
	// If not specified, use the first available device as default.
	id?: uint32
	// Maximum number of retries when sending to DLB device fails.
	// No retry as default.
	max_retries?:     uint32
	fallback_policy?: #Dlb_FallbackPolicy
}
