package v3

// Reads an environment variable to provide an input for matching.
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.environment_variable.v3.Config"
	// Name of the environment variable to read from.
	name?: string
}
