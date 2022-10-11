package v2alpha

// Wrapper for all fully buffered and streamed tap traces that Envoy emits. This is required for
// sending traces over gRPC APIs or more easily persisting binary messages to files.
#TraceWrapper: {
	"@type": "type.googleapis.com/envoy.data.tap.v2alpha.TraceWrapper"
	// An HTTP buffered tap trace.
	http_buffered_trace?: #HttpBufferedTrace
	// An HTTP streamed tap trace segment.
	http_streamed_trace_segment?: #HttpStreamedTraceSegment
	// A socket buffered tap trace.
	socket_buffered_trace?: #SocketBufferedTrace
	// A socket streamed tap trace segment.
	socket_streamed_trace_segment?: #SocketStreamedTraceSegment
}
