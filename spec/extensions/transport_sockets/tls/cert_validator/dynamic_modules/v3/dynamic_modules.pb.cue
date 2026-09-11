package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// Configuration for the dynamic module certificate validator.
//
// Example:
//
// .. validated-code-block:: yaml
//
//	:type-name: envoy.extensions.transport_sockets.tls.v3.CertificateValidationContext
//
//	custom_validator_config:
//	  name: envoy.tls.cert_validator.dynamic_modules
//	  typed_config:
//	    "@type": type.googleapis.com/envoy.extensions.transport_sockets.tls.cert_validator.dynamic_modules.v3.DynamicModuleCertValidatorConfig
//	    dynamic_module_config:
//	      name: my_module
//	    validator_name: my_validator
#DynamicModuleCertValidatorConfig: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.cert_validator.dynamic_modules.v3.DynamicModuleCertValidatorConfig"
	// Dynamic module configuration. See :ref:`dynamic module configuration
	// <envoy_v3_api_msg_extensions.dynamic_modules.v3.DynamicModuleConfig>` for details.
	dynamic_module_config?: v3.#DynamicModuleConfig
	// The name of the cert validator implementation in the dynamic module.
	// This is passed to the module's “envoy_dynamic_module_on_cert_validator_config_new“
	// function.
	validator_name?: string
	// Optional configuration for the cert validator. This is passed as bytes to the dynamic module.
	validator_config?: _
}
