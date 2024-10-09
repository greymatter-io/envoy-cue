package v3

import (
	v1 "envoyproxy.io/deps/census-instrumentation/opencensus-proto/gen-go/trace/v1"
	v3 "envoyproxy.io/config/core/v3"
)

#OpenCensusConfig_TraceContext: "NONE" | "TRACE_CONTEXT" | "GRPC_TRACE_BIN" | "CLOUD_TRACE_CONTEXT" | "B3"

OpenCensusConfig_TraceContext_NONE:                "NONE"
OpenCensusConfig_TraceContext_TRACE_CONTEXT:       "TRACE_CONTEXT"
OpenCensusConfig_TraceContext_GRPC_TRACE_BIN:      "GRPC_TRACE_BIN"
OpenCensusConfig_TraceContext_CLOUD_TRACE_CONTEXT: "CLOUD_TRACE_CONTEXT"
OpenCensusConfig_TraceContext_B3:                  "B3"

// Configuration for the OpenCensus tracer.
// [#next-free-field: 15]
// [#extension: envoy.tracers.opencensus]
#OpenCensusConfig: {
	"@type": "type.googleapis.com/envoy.config.trace.v3.OpenCensusConfig"
	// Configures tracing, e.g. the sampler, max number of annotations, etc.
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/opencensus.proto.
	trace_config?: v1.#TraceConfig
	// Enables the stdout exporter if set to true. This is intended for debugging
	// purposes.
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/opencensus.proto.
	stdout_exporter_enabled?: bool
	// Enables the Stackdriver exporter if set to true. The project_id must also
	// be set.
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/opencensus.proto.
	stackdriver_exporter_enabled?: bool
	// The Cloud project_id to use for Stackdriver tracing.
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/opencensus.proto.
	stackdriver_project_id?: string
	// (optional) By default, the Stackdriver exporter will connect to production
	// Stackdriver. If stackdriver_address is non-empty, it will instead connect
	// to this address, which is in the gRPC format:
	// https://github.com/grpc/grpc/blob/master/doc/naming.md
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/opencensus.proto.
	stackdriver_address?: string
	// (optional) The gRPC server that hosts Stackdriver tracing service. Only
	// Google gRPC is supported. If :ref:`target_uri <envoy_v3_api_field_config.core.v3.GrpcService.GoogleGrpc.target_uri>`
	// is not provided, the default production Stackdriver address will be used.
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/opencensus.proto.
	stackdriver_grpc_service?: v3.#GrpcService
	// Enables the Zipkin exporter if set to true. The url and service name must
	// also be set. This is deprecated, prefer to use Envoy's :ref:`native Zipkin
	// tracer <envoy_v3_api_msg_config.trace.v3.ZipkinConfig>`.
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/opencensus.proto.
	zipkin_exporter_enabled?: bool
	// The URL to Zipkin, e.g. "http://127.0.0.1:9411/api/v2/spans". This is
	// deprecated, prefer to use Envoy's :ref:`native Zipkin tracer
	// <envoy_v3_api_msg_config.trace.v3.ZipkinConfig>`.
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/opencensus.proto.
	zipkin_url?: string
	// Enables the OpenCensus Agent exporter if set to true. The ocagent_address or
	// ocagent_grpc_service must also be set.
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/opencensus.proto.
	ocagent_exporter_enabled?: bool
	// The address of the OpenCensus Agent, if its exporter is enabled, in gRPC
	// format: https://github.com/grpc/grpc/blob/master/doc/naming.md
	// [#comment:TODO: deprecate this field]
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/opencensus.proto.
	ocagent_address?: string
	// (optional) The gRPC server hosted by the OpenCensus Agent. Only Google gRPC is supported.
	// This is only used if the ocagent_address is left empty.
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/opencensus.proto.
	ocagent_grpc_service?: v3.#GrpcService
	// List of incoming trace context headers we will accept. First one found
	// wins.
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/opencensus.proto.
	incoming_trace_context?: [...#OpenCensusConfig_TraceContext]
	// List of outgoing trace context headers we will produce.
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/opencensus.proto.
	outgoing_trace_context?: [...#OpenCensusConfig_TraceContext]
}
