package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/common/mutation_rules/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#BodyTransformation_TransformAction: "MERGE" | "REPLACE"

BodyTransformation_TransformAction_MERGE:   "MERGE"
BodyTransformation_TransformAction_REPLACE: "REPLACE"

// Configuration for the transform filter. The filter may buffer the request/response until the
// entire body is received, and then mutate the headers and body according to the contents
// of the request/response. The request and response transformations are independent and could
// be configured separately.
// Only JSON body transformation is supported for now.
#TransformConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.transform.v3.TransformConfig"
	// Configuration for transforming request.
	//
	// .. note::
	//
	//	If set then the entire request headers and body will always be buffered on a JSON request
	//	even if only headers are transformed.
	request_transformation?: #Transformation
	// Configuration for transforming response.
	//
	// .. note::
	//
	//	If set then the entire response headers and body will always be buffered on a JSON response
	//	even if only headers are transformed.
	response_transformation?: #Transformation
	// If true and the request headers are transformed, Envoy will re-evaluate the target
	// cluster in the same route. Please ensure the cluster specifier in the route supports
	// dynamic evaluation or this flag will have no effect, e.g.
	// :ref:`matcher cluster specifier
	// <envoy_v3_api_msg_extensions.router.cluster_specifiers.matcher.v3.MatcherClusterSpecifier>`.
	//
	// Only one of “clear_cluster_cache“ and “clear_route_cache“ can be true.
	clear_cluster_cache?: bool
	// If true and the request headers are transformed, Envoy will clear the route cache for
	// the current request and force re-evaluation of the route. This has performance penalty and
	// should only be used when the route match criteria depends on the transformed headers.
	//
	// Only one of “clear_cluster_cache“ and “clear_route_cache“ can be true.
	clear_route_cache?: bool
}

#Transformation: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.transform.v3.Transformation"
	// The header mutations to perform.
	// The :ref:`substitution format specifier <config_access_log_format>` could be applied here.
	// In addition to the commonly used format specifiers, this filter introduces additional format specifiers:
	//
	//   - “%REQUEST_BODY(KEY*)%“: the request body. And “Key“ KEY is an optional
	//     lookup key in the namespace with the option of specifying nested keys separated by ':'.
	//   - “%RESPONSE_BODY(KEY*)%“: the response body. And “Key“ KEY is an optional
	//     lookup key in the namespace with the option of specifying nested keys separated by ':'.
	headers_mutations?: [...v3.#HeaderMutation]
	// The body transformation configuration. If not set, no body transformation will be performed.
	body_transformation?: #BodyTransformation
}

#BodyTransformation: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.transform.v3.BodyTransformation"
	// Body transformation configuration. The substitution format string is used as the template
	// to generate the transformed new body content.
	// The :ref:`substitution format specifier <config_access_log_format>` could be applied here.
	// And except the commonly used format specifiers, the additional format specifiers
	// “%REQUEST_BODY(KEY*)%“ and “%RESPONSE_BODY(KEY*)%“ could also be used here.
	body_format?: v31.#SubstitutionFormatString
	// The action to perform for new body content and original body content.
	// For example, if “MERGE“ is used, then the new body content generated from the “body_format“
	// will be merged into the original body content.
	//
	// Default is “MERGE“.
	action?: #BodyTransformation_TransformAction
}
