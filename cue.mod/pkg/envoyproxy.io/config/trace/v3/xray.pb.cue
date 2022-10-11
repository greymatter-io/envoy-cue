package v3

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
	v3 "envoyproxy.io/config/core/v3"
)

// [#extension: envoy.tracers.xray]
#XRayConfig: {
	"@type": "type.googleapis.com/envoy.config.trace.v3.XRayConfig"
	// The UDP endpoint of the X-Ray Daemon where the spans will be sent.
	// If this value is not set, the default value of 127.0.0.1:2000 will be used.
	daemon_endpoint?: v3.#SocketAddress
	// The name of the X-Ray segment.
	segment_name?: string
	// The location of a local custom sampling rules JSON file.
	// For an example of the sampling rules see:
	// `X-Ray SDK documentation
	// <https://docs.aws.amazon.com/xray/latest/devguide/xray-sdk-go-configuration.html#xray-sdk-go-configuration-sampling>`_
	sampling_rule_manifest?: v3.#DataSource
	// Optional custom fields to be added to each trace segment.
	// see: `X-Ray Segment Document documentation
	// <https://docs.aws.amazon.com/xray/latest/devguide/xray-api-segmentdocuments.html>`__
	segment_fields?: #XRayConfig_SegmentFields
}

#XRayConfig_SegmentFields: {
	"@type": "type.googleapis.com/envoy.config.trace.v3.XRayConfig_SegmentFields"
	// The type of AWS resource, e.g. "AWS::AppMesh::Proxy".
	origin?: string
	// AWS resource metadata dictionary.
	// See: `X-Ray Segment Document documentation <https://docs.aws.amazon.com/xray/latest/devguide/xray-api-segmentdocuments.html#api-segmentdocuments-aws>`__
	aws?: _struct.#Struct
}
