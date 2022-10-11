package v3

// The tracing configuration specifies settings for an HTTP tracer provider used by Envoy.
//
// Envoy may support other tracers in the future, but right now the HTTP tracer is the only one
// supported.
//
// .. attention::
//
//   Use of this message type has been deprecated in favor of direct use of
//   :ref:`Tracing.Http <envoy_v3_api_msg_config.trace.v3.Tracing.Http>`.
#Tracing: {
	"@type": "type.googleapis.com/envoy.config.trace.v3.Tracing"
	// Provides configuration for the HTTP tracer.
	http?: #Tracing_Http
}

// Configuration for an HTTP tracer provider used by Envoy.
//
// The configuration is defined by the
// :ref:`HttpConnectionManager.Tracing <envoy_v3_api_msg_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.Tracing>`
// :ref:`provider <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.Tracing.provider>`
// field.
#Tracing_Http: {
	"@type": "type.googleapis.com/envoy.config.trace.v3.Tracing_Http"
	// The name of the HTTP trace driver to instantiate. The name must match a
	// supported HTTP trace driver.
	// See the :ref:`extensions listed in typed_config below <extension_category_envoy.tracers>` for the default list of the HTTP trace driver.
	name?:         string
	typed_config?: _
}
