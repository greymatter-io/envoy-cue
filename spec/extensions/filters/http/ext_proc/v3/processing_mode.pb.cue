package v3

// Control how headers and trailers are handled
#ProcessingMode_HeaderSendMode: "DEFAULT" | "SEND" | "SKIP"

ProcessingMode_HeaderSendMode_DEFAULT: "DEFAULT"
ProcessingMode_HeaderSendMode_SEND:    "SEND"
ProcessingMode_HeaderSendMode_SKIP:    "SKIP"

// Control how the request and response bodies are handled
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
