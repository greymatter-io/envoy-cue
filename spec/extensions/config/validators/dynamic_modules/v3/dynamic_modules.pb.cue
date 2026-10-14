package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// Configuration for an xDS config validator implemented by a dynamic module. For each xDS update the
// module receives the xDS type URL and the decoded resources, with each resource carrying its name,
// version, aliases, TTL, and re-serialized protobuf payload. During validation the module can also
// read current server state, such as the dynamic cluster count, through the validation context. A
// rejection from the module follows Envoy's normal xDS rejection path, so the xDS client receives a
// NACK and the last accepted configuration is retained.
#DynamicModuleConfigValidator: {
	"@type": "type.googleapis.com/envoy.extensions.config.validators.dynamic_modules.v3.DynamicModuleConfigValidator"
	// Specifies the shared-object level configuration. This field is required.
	//
	// Only the ``name`` and ``module.local.filename`` sources are supported. Remote module sources
	// are not supported because config validators are created without a factory context.
	dynamic_module_config?: v3.#DynamicModuleConfig
	// The name identifying the config validator implementation within the module. This is passed to
	// the module's config validator init function so that a module can host multiple
	// implementations. This field is required.
	extension_name?: string
	// The configuration for the implementation chosen by ``extension_name``. If not specified, an
	// empty configuration is passed to the module.
	//
	// ``google.protobuf.Struct`` and the ``value`` field of ``xds.type.v3.TypedStruct`` are
	// serialized as JSON before passing them to the module.
	// ``google.protobuf.BytesValue`` and ``google.protobuf.StringValue`` are passed directly without
	// the wrapper. Otherwise the serialized bytes of the configured message are passed.
	extension_config?: _
	// The xDS resource type URLs handled by this validator. Only updates whose type URL matches one
	// of these values invoke the module. Each value must use the canonical
	// ``type.googleapis.com/<message>`` form. Exactly one type URL is supported today and this
	// restriction may be relaxed in the future. This field is required.
	type_urls?: [...string]
}
