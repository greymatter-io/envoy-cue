package v3

// Configuration for the Dynatrace Resource Detector extension.
// The resource detector reads from the Dynatrace enrichment files
// and adds host/process related attributes to the OpenTelemetry resource.
//
// See:
//
// `Enrich ingested data with Dynatrace-specific dimensions <https://docs.dynatrace.com/docs/shortlink/enrichment-files>`_
//
// [#extension: envoy.tracers.opentelemetry.resource_detectors.dynatrace]
#DynatraceResourceDetectorConfig: {
	"@type": "type.googleapis.com/envoy.extensions.tracers.opentelemetry.resource_detectors.v3.DynatraceResourceDetectorConfig"
}
