package v3

// Which schema translation leg to perform on a given path.
#Transcoder_Direction: "DIRECTION_UNSPECIFIED" | "TO_IR" | "FROM_IR"

Transcoder_Direction_DIRECTION_UNSPECIFIED: "DIRECTION_UNSPECIFIED"
Transcoder_Direction_TO_IR:                 "TO_IR"
Transcoder_Direction_FROM_IR:               "FROM_IR"

// Rewrites an AI request or response payload from one vendor's API schema into another's, using
// the declarative transcoding engine.
//
// All schemas are translated through a single canonical form -- OpenAI Chat Completions -- so
// that adding a dialect costs one declarative rule set rather than a rule set per pair. Filters
// placed between the two legs therefore only ever need to understand the canonical form.
#Transcoder: {
	"@type": "type.googleapis.com/envoy.extensions.http.ai_filters.transcoder.v3.Transcoder"
	// Request-side transcoding direction. When unset (``DIRECTION_UNSPECIFIED``), the request
	// decode path forwards the payload untouched. At least one of ``request_handling`` or
	// ``response_handling`` must be set.
	request_handling?: #Transcoder_Direction
	// Response-side transcoding direction. When unset (``DIRECTION_UNSPECIFIED``), response
	// transcoding (``encodeUnary`` and ``encodeSSE``) is disabled and responses pass through
	// untouched.
	response_handling?: #Transcoder_Direction
}
