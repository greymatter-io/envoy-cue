package v2alpha

// Wrapper for tapped body data. This includes HTTP request/response body, transport socket received
// and transmitted data, etc.
#Body: {
	"@type": "type.googleapis.com/envoy.data.tap.v2alpha.Body"
	// Body data as bytes. By default, tap body data will be present in this field, as the proto
	// `bytes` type can contain any valid byte.
	as_bytes?: bytes
	// Body data as string. This field is only used when the :ref:`JSON_BODY_AS_STRING
	// <envoy_api_enum_value_service.tap.v2alpha.OutputSink.Format.JSON_BODY_AS_STRING>` sink
	// format type is selected. See the documentation for that option for why this is useful.
	as_string?: string
	// Specifies whether body data has been truncated to fit within the specified
	// :ref:`max_buffered_rx_bytes
	// <envoy_api_field_service.tap.v2alpha.OutputConfig.max_buffered_rx_bytes>` and
	// :ref:`max_buffered_tx_bytes
	// <envoy_api_field_service.tap.v2alpha.OutputConfig.max_buffered_tx_bytes>` settings.
	truncated?: bool
}
