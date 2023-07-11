package v2alpha

// The injected resource monitor allows injecting a synthetic resource pressure into Envoy
// via a text file, which must contain a floating-point number in the range [0..1] representing
// the resource pressure and be updated atomically by a symbolic link swap.
// This is intended primarily for integration tests to force Envoy into an overloaded state.
#InjectedResourceConfig: {
	"@type":   "type.googleapis.com/envoy.config.resource_monitor.injected_resource.v2alpha.InjectedResourceConfig"
	filename?: string
}
