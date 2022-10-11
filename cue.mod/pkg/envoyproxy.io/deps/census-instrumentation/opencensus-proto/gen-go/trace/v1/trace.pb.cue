package v1

import (
	v1 "envoyproxy.io/deps/census-instrumentation/opencensus-proto/gen-go/resource/v1"
)

// Type of span. Can be used to specify additional relationships between spans
// in addition to a parent/child relationship.
#Span_SpanKind: "SPAN_KIND_UNSPECIFIED" | "SERVER" | "CLIENT"

Span_SpanKind_SPAN_KIND_UNSPECIFIED: "SPAN_KIND_UNSPECIFIED"
Span_SpanKind_SERVER:                "SERVER"
Span_SpanKind_CLIENT:                "CLIENT"

// Indicates whether the message was sent or received.
#Span_TimeEvent_MessageEvent_Type: "TYPE_UNSPECIFIED" | "SENT" | "RECEIVED"

Span_TimeEvent_MessageEvent_Type_TYPE_UNSPECIFIED: "TYPE_UNSPECIFIED"
Span_TimeEvent_MessageEvent_Type_SENT:             "SENT"
Span_TimeEvent_MessageEvent_Type_RECEIVED:         "RECEIVED"

// The relationship of the current span relative to the linked span: child,
// parent, or unspecified.
#Span_Link_Type: "TYPE_UNSPECIFIED" | "CHILD_LINKED_SPAN" | "PARENT_LINKED_SPAN"

Span_Link_Type_TYPE_UNSPECIFIED:   "TYPE_UNSPECIFIED"
Span_Link_Type_CHILD_LINKED_SPAN:  "CHILD_LINKED_SPAN"
Span_Link_Type_PARENT_LINKED_SPAN: "PARENT_LINKED_SPAN"

// A span represents a single operation within a trace. Spans can be
// nested to form a trace tree. Spans may also be linked to other spans
// from the same or different trace. And form graphs. Often, a trace
// contains a root span that describes the end-to-end latency, and one
// or more subspans for its sub-operations. A trace can also contain
// multiple root spans, or none at all. Spans do not need to be
// contiguous - there may be gaps or overlaps between spans in a trace.
//
// The next id is 17.
// TODO(bdrutu): Add an example.
#Span: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.Span"
	// A unique identifier for a trace. All spans from the same trace share
	// the same `trace_id`. The ID is a 16-byte array. An ID with all zeroes
	// is considered invalid.
	//
	// This field is semantically required. Receiver should generate new
	// random trace_id if empty or invalid trace_id was received.
	//
	// This field is required.
	trace_id?: bytes
	// A unique identifier for a span within a trace, assigned when the span
	// is created. The ID is an 8-byte array. An ID with all zeroes is considered
	// invalid.
	//
	// This field is semantically required. Receiver should generate new
	// random span_id if empty or invalid span_id was received.
	//
	// This field is required.
	span_id?: bytes
	// The Tracestate on the span.
	tracestate?: #Span_Tracestate
	// The `span_id` of this span's parent span. If this is a root span, then this
	// field must be empty. The ID is an 8-byte array.
	parent_span_id?: bytes
	// A description of the span's operation.
	//
	// For example, the name can be a qualified method name or a file name
	// and a line number where the operation is called. A best practice is to use
	// the same display name at the same call point in an application.
	// This makes it easier to correlate spans in different traces.
	//
	// This field is semantically required to be set to non-empty string.
	// When null or empty string received - receiver may use string "name"
	// as a replacement. There might be smarted algorithms implemented by
	// receiver to fix the empty span name.
	//
	// This field is required.
	name?: #TruncatableString
	// Distinguishes between spans generated in a particular context. For example,
	// two spans with the same name may be distinguished using `CLIENT` (caller)
	// and `SERVER` (callee) to identify queueing latency associated with the span.
	kind?: #Span_SpanKind
	// The start time of the span. On the client side, this is the time kept by
	// the local machine where the span execution starts. On the server side, this
	// is the time when the server's application handler starts running.
	//
	// This field is semantically required. When not set on receive -
	// receiver should set it to the value of end_time field if it was
	// set. Or to the current time if neither was set. It is important to
	// keep end_time > start_time for consistency.
	//
	// This field is required.
	start_time?: string
	// The end time of the span. On the client side, this is the time kept by
	// the local machine where the span execution ends. On the server side, this
	// is the time when the server application handler stops running.
	//
	// This field is semantically required. When not set on receive -
	// receiver should set it to start_time value. It is important to
	// keep end_time > start_time for consistency.
	//
	// This field is required.
	end_time?: string
	// A set of attributes on the span.
	attributes?: #Span_Attributes
	// A stack trace captured at the start of the span.
	stack_trace?: #StackTrace
	// The included time events.
	time_events?: #Span_TimeEvents
	// The included links.
	links?: #Span_Links
	// An optional final status for this span. Semantically when Status
	// wasn't set it is means span ended without errors and assume
	// Status.Ok (code = 0).
	status?: #Status
	// An optional resource that is associated with this span. If not set, this span
	// should be part of a batch that does include the resource information, unless resource
	// information is unknown.
	resource?: v1.#Resource
	// A highly recommended but not required flag that identifies when a
	// trace crosses a process boundary. True when the parent_span belongs
	// to the same process as the current span. This flag is most commonly
	// used to indicate the need to adjust time as clocks in different
	// processes may not be synchronized.
	same_process_as_parent_span?: bool
	// An optional number of child spans that were generated while this span
	// was active. If set, allows an implementation to detect missing child spans.
	child_span_count?: uint32
}

// The `Status` type defines a logical error model that is suitable for different
// programming environments, including REST APIs and RPC APIs. This proto's fields
// are a subset of those of
// [google.rpc.Status](https://github.com/googleapis/googleapis/blob/master/google/rpc/status.proto),
// which is used by [gRPC](https://github.com/grpc).
#Status: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.Status"
	// The status code. This is optional field. It is safe to assume 0 (OK)
	// when not set.
	code?: int32
	// A developer-facing error message, which should be in English.
	message?: string
}

// The value of an Attribute.
#AttributeValue: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.AttributeValue"
	// A string up to 256 bytes long.
	string_value?: #TruncatableString
	// A 64-bit signed integer.
	int_value?: int64
	// A Boolean value represented by `true` or `false`.
	bool_value?: bool
	// A double value.
	double_value?: float64
}

// The call stack which originated this span.
#StackTrace: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.StackTrace"
	// Stack frames in this stack trace.
	stack_frames?: #StackTrace_StackFrames
	// The hash ID is used to conserve network bandwidth for duplicate
	// stack traces within a single trace.
	//
	// Often multiple spans will have identical stack traces.
	// The first occurrence of a stack trace should contain both
	// `stack_frames` and a value in `stack_trace_hash_id`.
	//
	// Subsequent spans within the same request can refer
	// to that stack trace by setting only `stack_trace_hash_id`.
	//
	// TODO: describe how to deal with the case where stack_trace_hash_id is
	// zero because it was not set.
	stack_trace_hash_id?: uint64
}

// A description of a binary module.
#Module: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.Module"
	// TODO: document the meaning of this field.
	// For example: main binary, kernel modules, and dynamic libraries
	// such as libc.so, sharedlib.so.
	module?: #TruncatableString
	// A unique identifier for the module, usually a hash of its
	// contents.
	build_id?: #TruncatableString
}

// A string that might be shortened to a specified length.
#TruncatableString: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.TruncatableString"
	// The shortened string. For example, if the original string was 500 bytes long and
	// the limit of the string was 128 bytes, then this value contains the first 128
	// bytes of the 500-byte string. Note that truncation always happens on a
	// character boundary, to ensure that a truncated string is still valid UTF-8.
	// Because it may contain multi-byte characters, the size of the truncated string
	// may be less than the truncation limit.
	value?: string
	// The number of bytes removed from the original string. If this
	// value is 0, then the string was not shortened.
	truncated_byte_count?: int32
}

// This field conveys information about request position in multiple distributed tracing graphs.
// It is a list of Tracestate.Entry with a maximum of 32 members in the list.
//
// See the https://github.com/w3c/distributed-tracing for more details about this field.
#Span_Tracestate: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.Span_Tracestate"
	// A list of entries that represent the Tracestate.
	entries?: [...#Span_Tracestate_Entry]
}

// A set of attributes, each with a key and a value.
#Span_Attributes: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.Span_Attributes"
	// The set of attributes. The value can be a string, an integer, a double
	// or the Boolean values `true` or `false`. Note, global attributes like
	// server name can be set as tags using resource API. Examples of attributes:
	//
	//     "/http/user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"
	//     "/http/server_latency": 300
	//     "abc.com/myattribute": true
	//     "abc.com/score": 10.239
	attribute_map?: [string]: #AttributeValue
	// The number of attributes that were discarded. Attributes can be discarded
	// because their keys are too long or because there are too many attributes.
	// If this value is 0, then no attributes were dropped.
	dropped_attributes_count?: int32
}

// A time-stamped annotation or message event in the Span.
#Span_TimeEvent: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.Span_TimeEvent"
	// The time the event occurred.
	time?: string
	// A text annotation with a set of attributes.
	annotation?: #Span_TimeEvent_Annotation
	// An event describing a message sent/received between Spans.
	message_event?: #Span_TimeEvent_MessageEvent
}

// A collection of `TimeEvent`s. A `TimeEvent` is a time-stamped annotation
// on the span, consisting of either user-supplied key-value pairs, or
// details of a message sent/received between Spans.
#Span_TimeEvents: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.Span_TimeEvents"
	// A collection of `TimeEvent`s.
	time_event?: [...#Span_TimeEvent]
	// The number of dropped annotations in all the included time events.
	// If the value is 0, then no annotations were dropped.
	dropped_annotations_count?: int32
	// The number of dropped message events in all the included time events.
	// If the value is 0, then no message events were dropped.
	dropped_message_events_count?: int32
}

// A pointer from the current span to another span in the same trace or in a
// different trace. For example, this can be used in batching operations,
// where a single batch handler processes multiple requests from different
// traces or when the handler receives a request from a different project.
#Span_Link: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.Span_Link"
	// A unique identifier of a trace that this linked span is part of. The ID is a
	// 16-byte array.
	trace_id?: bytes
	// A unique identifier for the linked span. The ID is an 8-byte array.
	span_id?: bytes
	// The relationship of the current span relative to the linked span.
	type?: #Span_Link_Type
	// A set of attributes on the link.
	attributes?: #Span_Attributes
	// The Tracestate associated with the link.
	tracestate?: #Span_Tracestate
}

// A collection of links, which are references from this span to a span
// in the same or different trace.
#Span_Links: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.Span_Links"
	// A collection of links.
	link?: [...#Span_Link]
	// The number of dropped links after the maximum size was enforced. If
	// this value is 0, then no links were dropped.
	dropped_links_count?: int32
}

#Span_Tracestate_Entry: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.Span_Tracestate_Entry"
	// The key must begin with a lowercase letter, and can only contain
	// lowercase letters 'a'-'z', digits '0'-'9', underscores '_', dashes
	// '-', asterisks '*', and forward slashes '/'.
	key?: string
	// The value is opaque string up to 256 characters printable ASCII
	// RFC0020 characters (i.e., the range 0x20 to 0x7E) except ',' and '='.
	// Note that this also excludes tabs, newlines, carriage returns, etc.
	value?: string
}

// A text annotation with a set of attributes.
#Span_TimeEvent_Annotation: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.Span_TimeEvent_Annotation"
	// A user-supplied message describing the event.
	description?: #TruncatableString
	// A set of attributes on the annotation.
	attributes?: #Span_Attributes
}

// An event describing a message sent/received between Spans.
#Span_TimeEvent_MessageEvent: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.Span_TimeEvent_MessageEvent"
	// The type of MessageEvent. Indicates whether the message was sent or
	// received.
	type?: #Span_TimeEvent_MessageEvent_Type
	// An identifier for the MessageEvent's message that can be used to match
	// SENT and RECEIVED MessageEvents. For example, this field could
	// represent a sequence ID for a streaming RPC. It is recommended to be
	// unique within a Span.
	id?: uint64
	// The number of uncompressed bytes sent or received.
	uncompressed_size?: uint64
	// The number of compressed bytes sent or received. If zero, assumed to
	// be the same size as uncompressed.
	compressed_size?: uint64
}

// A single stack frame in a stack trace.
#StackTrace_StackFrame: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.StackTrace_StackFrame"
	// The fully-qualified name that uniquely identifies the function or
	// method that is active in this frame.
	function_name?: #TruncatableString
	// An un-mangled function name, if `function_name` is
	// [mangled](http://www.avabodh.com/cxxin/namemangling.html). The name can
	// be fully qualified.
	original_function_name?: #TruncatableString
	// The name of the source file where the function call appears.
	file_name?: #TruncatableString
	// The line number in `file_name` where the function call appears.
	line_number?: int64
	// The column number where the function call appears, if available.
	// This is important in JavaScript because of its anonymous functions.
	column_number?: int64
	// The binary module from where the code was loaded.
	load_module?: #Module
	// The version of the deployed source code.
	source_version?: #TruncatableString
}

// A collection of stack frames, which can be truncated.
#StackTrace_StackFrames: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.StackTrace_StackFrames"
	// Stack frames in this call stack.
	frame?: [...#StackTrace_StackFrame]
	// The number of stack frames that were dropped because there
	// were too many stack frames.
	// If this value is 0, then no stack frames were dropped.
	dropped_frames_count?: int32
}
