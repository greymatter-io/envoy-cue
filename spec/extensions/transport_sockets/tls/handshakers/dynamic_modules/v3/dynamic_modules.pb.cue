package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// Configuration for the dynamic module TLS handshaker.
//
// Example:
//
// .. validated-code-block:: yaml
//
//	:type-name: envoy.extensions.transport_sockets.tls.v3.CommonTlsContext
//
//	custom_handshaker:
//	  name: envoy.tls.handshakers.dynamic_modules
//	  typed_config:
//	    "@type": type.googleapis.com/envoy.extensions.transport_sockets.tls.handshakers.dynamic_modules.v3.DynamicModuleTlsHandshaker
//	    dynamic_module_config:
//	      name: my_module
//	    handshaker_name: my_handshaker
#DynamicModuleTlsHandshaker: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.handshakers.dynamic_modules.v3.DynamicModuleTlsHandshaker"
	// Dynamic module configuration. See :ref:`dynamic module configuration
	// <envoy_v3_api_msg_extensions.dynamic_modules.v3.DynamicModuleConfig>` for details.
	dynamic_module_config?: v3.#DynamicModuleConfig
	// The name of the handshaker implementation in the dynamic module.
	// This is passed to the module's ``envoy_dynamic_module_on_tls_handshaker_config_new`` function.
	handshaker_name?: string
	// Optional configuration for the handshaker. This is passed as bytes to the dynamic module.
	// If not specified, no configuration bytes are passed to the module.
	handshaker_config?: _
}
