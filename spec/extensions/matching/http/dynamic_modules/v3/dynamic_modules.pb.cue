package v3

// Configuration for the dynamic modules HTTP match input. This input extracts HTTP request and
// response data from the matching context and makes it available to the dynamic module matcher
// via ABI callbacks during match evaluation.
//
// This data input should be used together with the
// :ref:`dynamic modules input matcher
// <envoy_v3_api_msg_extensions.matching.input_matchers.dynamic_modules.v3.DynamicModuleMatcher>`.
#HttpDynamicModuleMatchInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.http.dynamic_modules.v3.HttpDynamicModuleMatchInput"
}
