package v3

// This configuration allows the built-in PICK_FIRST LB policy to be configured
// via the LB policy extension point.
#PickFirst: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.pick_first.v3.PickFirst"
	// If set to true, instructs the LB policy to shuffle the list of addresses
	// received from the name resolver before attempting to connect to them.
	shuffle_address_list?: bool
}
