package v3

// Extension to save the
// :ref:`ProcessingResponse <envoy_v3_api_msg_service.ext_proc.v3.ProcessingResponse>` from the
// external processor as filter state with name
// “envoy.http.ext_proc.response_processors.save_processing_response“. If
// :ref:`filter_state_name_suffix <envoy_v3_api_field_extensions.http.ext_proc.response_processors.save_processing_response.v3.SaveProcessingResponse.filter_state_name_suffix>`
// is defined, it is appended to this name.
//
// This extension supports saving of request and response headers, request and response trailers,
// and immediate response.
//
// .. note::
//
//	Response processors are currently in alpha.
//
// [#next-free-field: 7]
#SaveProcessingResponse: {
	"@type": "type.googleapis.com/envoy.extensions.http.ext_proc.response_processors.save_processing_response.v3.SaveProcessingResponse"
	// The default filter state name is
	// “envoy.http.ext_proc.response_processors.save_processing_response“.
	// If defined, “filter_state_name_suffix“ is appended to this name.
	//
	// For example, setting “filter_state_name_suffix“ to “xyz“ will set the filter state name
	// to “envoy.http.ext_proc.response_processors.save_processing_response.xyz“.
	filter_state_name_suffix?: string
	// Save the response to filter state when
	// :ref:`request_headers <envoy_v3_api_field_service.ext_proc.v3.ProcessingResponse.request_headers>`
	// is set.
	save_request_headers?: #SaveProcessingResponse_SaveOptions
	// Save the response to filter state when
	// :ref:`response_headers <envoy_v3_api_field_service.ext_proc.v3.ProcessingResponse.response_headers>`
	// is set.
	save_response_headers?: #SaveProcessingResponse_SaveOptions
	// Save the response to filter state when
	// :ref:`request_trailers <envoy_v3_api_field_service.ext_proc.v3.ProcessingResponse.request_trailers>`
	// is set.
	save_request_trailers?: #SaveProcessingResponse_SaveOptions
	// Save the response to filter state when
	// :ref:`response_trailers <envoy_v3_api_field_service.ext_proc.v3.ProcessingResponse.response_trailers>`
	// is set.
	save_response_trailers?: #SaveProcessingResponse_SaveOptions
	// Save the response to filter state when
	// :ref:`immediate_response <envoy_v3_api_field_service.ext_proc.v3.ProcessingResponse.immediate_response>`
	// is set.
	save_immediate_response?: #SaveProcessingResponse_SaveOptions
}

// Options for saving the processing response.
#SaveProcessingResponse_SaveOptions: {
	"@type": "type.googleapis.com/envoy.extensions.http.ext_proc.response_processors.save_processing_response.v3.SaveProcessingResponse_SaveOptions"
	// When set to “true“, saves the response for the corresponding response type.
	//
	// Defaults to “false“.
	save_response?: bool
	// When set to “true“, saves the response if there was an error when processing the response
	// from the external processor.
	//
	// Defaults to “false“.
	save_on_error?: bool
}
