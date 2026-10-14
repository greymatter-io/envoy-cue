package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// Configuration for the Dynamic Modules HTTP/1 header formatter. This extension allows loading
// shared object files via “dlopen“ to decide the casing of header keys written on the wire,
// which is what the :ref:`preserve case formatter
// <envoy_v3_api_msg_extensions.http.header_formatters.preserve_case.v3.PreserveCaseFormatterConfig>`
// does with a fixed policy. See the :ref:`header casing
// <config_http_conn_man_header_casing>` configuration guide for how to select a stateful
// formatter.
//
// This extension only affects HTTP/1 traffic: HTTP/2 and HTTP/3 require lower-cased header keys.
#DynamicModuleHeaderFormatter: {
	"@type": "type.googleapis.com/envoy.extensions.http.header_formatters.dynamic_modules.v3.DynamicModuleHeaderFormatter"
	// Specifies the shared-object level configuration. This field is required.
	//
	// Only sources that are available synchronously are supported, i.e. ``name``, ``module.local``,
	// and a ``module.remote`` that is already present in the on-disk cache. A remote source that
	// would need to be fetched is rejected, since the codec must be able to format headers for the
	// first message the connection serves.
	dynamic_module_config?: v3.#DynamicModuleConfig
	// The name for this header formatter configuration. If not specified, defaults to an empty
	// string.
	//
	// This can be used to distinguish between different header formatter implementations inside a
	// dynamic module. When Envoy receives this configuration, it passes the
	// ``header_formatter_name`` to the dynamic module's header formatter config init function
	// together with the ``header_formatter_config``. That way a module can decide which in-module
	// implementation to use based on the name at load time.
	header_formatter_name?: string
	// The configuration for the header formatter chosen by ``header_formatter_name``. If not
	// specified, an empty configuration is passed to the module.
	//
	// This is passed to the module's header formatter initialization function. Together with the
	// ``header_formatter_name``, the module can decide which in-module implementation to use and
	// fine-tune its behavior.
	//
	// ``google.protobuf.Struct`` and the ``value`` field of ``xds.type.v3.TypedStruct`` are
	// serialized as JSON before passing them to the module.
	// ``google.protobuf.BytesValue`` and ``google.protobuf.StringValue`` are passed directly
	// without the wrapper.
	//
	// .. code-block:: yaml
	//
	//  # Passing a JSON struct configuration
	//  header_formatter_config:
	//    "@type": "type.googleapis.com/google.protobuf.Struct"
	//    value:
	//      known_headers:
	//      - X-Request-ID
	//
	//  # Passing a simple string configuration
	//  header_formatter_config:
	//    "@type": "type.googleapis.com/google.protobuf.StringValue"
	//    value: "proper_case"
	//
	header_formatter_config?: _
}
