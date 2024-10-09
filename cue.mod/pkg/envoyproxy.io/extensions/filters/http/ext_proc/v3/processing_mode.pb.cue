package v3

// Control how headers and trailers are handled
#ProcessingMode_HeaderSendMode: "DEFAULT" | "SEND" | "SKIP"

ProcessingMode_HeaderSendMode_DEFAULT: "DEFAULT"
ProcessingMode_HeaderSendMode_SEND:    "SEND"
ProcessingMode_HeaderSendMode_SKIP:    "SKIP"

// Control how the request and response bodies are handled
// When body mutation by external processor is enabled, ext_proc filter will always remove
// the content length header in three cases below because content length can not be guaranteed
// to be set correctly:
// 1) STREAMED BodySendMode: header processing completes before body mutation comes back.
// 2) BUFFERED_PARTIAL BodySendMode: body is buffered and could be injected in different phases.
// 3) BUFFERED BodySendMode + SKIP HeaderSendMode: header processing (e.g., update content-length) is skipped.
//
// In Envoy's http1 codec implementation, removing content length will enable chunked transfer
// encoding whenever feasible. The recipient (either client or server) must be able
// to parse and decode the chunked transfer coding.
// (see `details in RFC9112 <https://tools.ietf.org/html/rfc9112#section-7.1>`_).
//
// In BUFFERED BodySendMode + SEND HeaderSendMode, content length header is allowed but it is
// external processor's responsibility to set the content length correctly matched to the length
// of mutated body. If they don't match, the corresponding body mutation will be rejected and
// local reply will be sent with an error message.
#ProcessingMode_BodySendMode: "NONE" | "STREAMED" | "BUFFERED" | "BUFFERED_PARTIAL"

ProcessingMode_BodySendMode_NONE:             "NONE"
ProcessingMode_BodySendMode_STREAMED:         "STREAMED"
ProcessingMode_BodySendMode_BUFFERED:         "BUFFERED"
ProcessingMode_BodySendMode_BUFFERED_PARTIAL: "BUFFERED_PARTIAL"

// [#next-free-field: 7]
#ProcessingMode: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_proc.v3.ProcessingMode"
	// How to handle the request header. Default is "SEND".
	request_header_mode?: #ProcessingMode_HeaderSendMode
	// How to handle the response header. Default is "SEND".
	response_header_mode?: #ProcessingMode_HeaderSendMode
	// How to handle the request body. Default is "NONE".
	request_body_mode?: #ProcessingMode_BodySendMode
	// How do handle the response body. Default is "NONE".
	response_body_mode?: #ProcessingMode_BodySendMode
	// How to handle the request trailers. Default is "SKIP".
	request_trailer_mode?: #ProcessingMode_HeaderSendMode
	// How to handle the response trailers. Default is "SKIP".
	response_trailer_mode?: #ProcessingMode_HeaderSendMode
}
