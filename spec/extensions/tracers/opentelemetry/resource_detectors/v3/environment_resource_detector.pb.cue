package v3

// Configuration for the Environment Resource detector extension.
// The resource detector reads from the “OTEL_RESOURCE_ATTRIBUTES“
// environment variable, as per the OpenTelemetry specification.
//
// See:
//
// `OpenTelemetry specification <https://github.com/open-telemetry/opentelemetry-specification/blob/v1.24.0/specification/resource/sdk.md#detecting-resource-information-from-the-environment>`_
//
// [#extension: envoy.tracers.opentelemetry.resource_detectors.environment]
#EnvironmentResourceDetectorConfig: {
	"@type": "type.googleapis.com/envoy.extensions.tracers.opentelemetry.resource_detectors.v3.EnvironmentResourceDetectorConfig"
}
