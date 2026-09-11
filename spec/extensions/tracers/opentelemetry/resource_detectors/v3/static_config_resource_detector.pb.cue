package v3

// Configuration for the Static Resource detector extension.
// The resource detector uses static config for resource attribute,
// as per the OpenTelemetry specification.
//
// [#extension: envoy.tracers.opentelemetry.resource_detectors.static_config]
#StaticConfigResourceDetectorConfig: {
	"@type": "type.googleapis.com/envoy.extensions.tracers.opentelemetry.resource_detectors.v3.StaticConfigResourceDetectorConfig"
	// Custom Resource attributes to be included.
	attributes?: [string]: string
}
