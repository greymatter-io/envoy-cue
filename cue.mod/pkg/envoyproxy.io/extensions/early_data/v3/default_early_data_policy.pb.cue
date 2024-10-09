package v3

// [#extension: envoy.route.early_data_policy.default]
// The default rule to allow/disallow a request to be sent as early data. It's an empty config now. Configuring it will disallow any request to be sent over early data.
#DefaultEarlyDataPolicy: {
	"@type": "type.googleapis.com/envoy.extensions.early_data.v3.DefaultEarlyDataPolicy"
}
