package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// Configuration for a transport socket implemented by a dynamic module. The transport socket
// performs the raw I/O for a connection and may transform the bytes that flow over it, for example
// to implement a custom encryption scheme.
//
// Example:
//
// .. code-block:: yaml
//
//	transport_socket:
//	  name: envoy.transport_sockets.dynamic_modules
//	  typed_config:
//	    "@type": type.googleapis.com/envoy.extensions.transport_sockets.dynamic_modules.v3.DynamicModuleTransportSocket
//	    dynamic_module_config:
//	      name: my_module
//	    transport_socket_name: my_transport_socket
#DynamicModuleTransportSocket: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.dynamic_modules.v3.DynamicModuleTransportSocket"
	// Dynamic module configuration. See :ref:`dynamic module configuration
	// <envoy_v3_api_msg_extensions.dynamic_modules.v3.DynamicModuleConfig>` for details.
	dynamic_module_config?: v3.#DynamicModuleConfig
	// The name of the transport socket implementation in the dynamic module. This is passed to the
	// module's “envoy_dynamic_module_on_transport_socket_factory_config_new“ function.
	transport_socket_name?: string
	// Optional configuration for the transport socket. This is passed as bytes to the dynamic module.
	// If not specified, no configuration bytes are passed to the module.
	transport_socket_config?: _
	// Whether the transport socket implements secure transport. Set this to true for modules that
	// provide encryption so that Envoy treats connections using this transport socket as secure. If
	// not specified, defaults to false.
	implements_secure_transport?: bool
}
