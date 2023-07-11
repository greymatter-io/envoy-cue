package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Configuration for restricting Proxy-Wasm capabilities available to modules.
#CapabilityRestrictionConfig: {
	"@type": "type.googleapis.com/envoy.extensions.wasm.v3.CapabilityRestrictionConfig"
	// The Proxy-Wasm capabilities which will be allowed. Capabilities are mapped by
	// name. The ``SanitizationConfig`` which each capability maps to is currently unimplemented and ignored,
	// and so should be left empty.
	//
	// The capability names are given in the
	// `Proxy-Wasm ABI <https://github.com/proxy-wasm/spec/tree/master/abi-versions/vNEXT>`_.
	// Additionally, the following WASI capabilities from
	// `this list <https://github.com/WebAssembly/WASI/blob/master/phases/snapshot/docs.md#modules>`_
	// are implemented and can be allowed:
	// ``fd_write``, ``fd_read``, ``fd_seek``, ``fd_close``, ``fd_fdstat_get``, ``environ_get``, ``environ_sizes_get``,
	// ``args_get``, ``args_sizes_get``, ``proc_exit``, ``clock_time_get``, ``random_get``.
	allowed_capabilities?: [string]: #SanitizationConfig
}

// Configuration for sanitization of inputs to an allowed capability.
//
// NOTE: This is currently unimplemented.
#SanitizationConfig: {
	"@type": "type.googleapis.com/envoy.extensions.wasm.v3.SanitizationConfig"
}

// Configuration for a Wasm VM.
// [#next-free-field: 8]
#VmConfig: {
	"@type": "type.googleapis.com/envoy.extensions.wasm.v3.VmConfig"
	// An ID which will be used along with a hash of the wasm code (or the name of the registered Null
	// VM plugin) to determine which VM will be used for the plugin. All plugins which use the same
	// ``vm_id`` and code will use the same VM. May be left blank. Sharing a VM between plugins can
	// reduce memory utilization and make sharing of data easier which may have security implications.
	// [#comment: TODO: add ref for details.]
	vm_id?: string
	// The Wasm runtime type, defaults to the first available Wasm engine used at Envoy build-time.
	// The priority to search for the available engine is: v8 -> wasmtime -> wamr -> wavm.
	// Available Wasm runtime types are registered as extensions. The following runtimes are included
	// in Envoy code base:
	//
	// .. _extension_envoy.wasm.runtime.null:
	//
	// **envoy.wasm.runtime.null**: Null sandbox, the Wasm module must be compiled and linked into the
	// Envoy binary. The registered name is given in the ``code`` field as ``inline_string``.
	//
	// .. _extension_envoy.wasm.runtime.v8:
	//
	// **envoy.wasm.runtime.v8**: `V8 <https://v8.dev/>`_-based WebAssembly runtime.
	//
	// .. _extension_envoy.wasm.runtime.wamr:
	//
	// **envoy.wasm.runtime.wamr**: `WAMR <https://github.com/bytecodealliance/wasm-micro-runtime/>`_-based WebAssembly runtime.
	// This runtime is not enabled in the official build.
	//
	// .. _extension_envoy.wasm.runtime.wavm:
	//
	// **envoy.wasm.runtime.wavm**: `WAVM <https://wavm.github.io/>`_-based WebAssembly runtime.
	// This runtime is not enabled in the official build.
	//
	// .. _extension_envoy.wasm.runtime.wasmtime:
	//
	// **envoy.wasm.runtime.wasmtime**: `Wasmtime <https://wasmtime.dev/>`_-based WebAssembly runtime.
	// This runtime is not enabled in the official build.
	//
	// [#extension-category: envoy.wasm.runtime]
	runtime?: string
	// The Wasm code that Envoy will execute.
	code?: v3.#AsyncDataSource
	// The Wasm configuration used in initialization of a new VM
	// (proxy_on_start). ``google.protobuf.Struct`` is serialized as JSON before
	// passing it to the plugin. ``google.protobuf.BytesValue`` and
	// ``google.protobuf.StringValue`` are passed directly without the wrapper.
	configuration?: _
	// Allow the wasm file to include pre-compiled code on VMs which support it.
	// Warning: this should only be enable for trusted sources as the precompiled code is not
	// verified.
	allow_precompiled?: bool
	// If true and the code needs to be remotely fetched and it is not in the cache then NACK the configuration
	// update and do a background fetch to fill the cache, otherwise fetch the code asynchronously and enter
	// warming state.
	nack_on_code_cache_miss?: bool
	// Specifies environment variables to be injected to this VM which will be available through
	// WASI's ``environ_get`` and ``environ_get_sizes`` system calls. Note that these functions are mostly implicitly
	// called in your language's standard library, so you do not need to call them directly and you can access to env
	// vars just like when you do on native platforms.
	// Warning: Envoy rejects the configuration if there's conflict of key space.
	environment_variables?: #EnvironmentVariables
}

#EnvironmentVariables: {
	"@type": "type.googleapis.com/envoy.extensions.wasm.v3.EnvironmentVariables"
	// The keys of *Envoy's* environment variables exposed to this VM. In other words, if a key exists in Envoy's environment
	// variables, then that key-value pair will be injected. Note that if a key does not exist, it will be ignored.
	host_env_keys?: [...string]
	// Explicitly given key-value pairs to be injected to this VM in the form of "KEY=VALUE".
	key_values?: [string]: string
}

// Base Configuration for Wasm Plugins e.g. filters and services.
// [#next-free-field: 7]
#PluginConfig: {
	"@type": "type.googleapis.com/envoy.extensions.wasm.v3.PluginConfig"
	// A unique name for a filters/services in a VM for use in identifying the filter/service if
	// multiple filters/services are handled by the same ``vm_id`` and ``root_id`` and for
	// logging/debugging.
	name?: string
	// A unique ID for a set of filters/services in a VM which will share a RootContext and Contexts
	// if applicable (e.g. an Wasm HttpFilter and an Wasm AccessLog). If left blank, all
	// filters/services with a blank root_id with the same ``vm_id`` will share Context(s).
	root_id?:   string
	vm_config?: #VmConfig
	// Filter/service configuration used to configure or reconfigure a plugin
	// (``proxy_on_configure``).
	// ``google.protobuf.Struct`` is serialized as JSON before
	// passing it to the plugin. ``google.protobuf.BytesValue`` and
	// ``google.protobuf.StringValue`` are passed directly without the wrapper.
	configuration?: _
	// If there is a fatal error on the VM (e.g. exception, abort(), on_start or on_configure return false),
	// then all plugins associated with the VM will either fail closed (by default), e.g. by returning an HTTP 503 error,
	// or fail open (if 'fail_open' is set to true) by bypassing the filter. Note: when on_start or on_configure return false
	// during xDS updates the xDS configuration will be rejected and when on_start or on_configuration return false on initial
	// startup the proxy will not start.
	fail_open?: bool
	// Configuration for restricting Proxy-Wasm capabilities available to modules.
	capability_restriction_config?: #CapabilityRestrictionConfig
}

// WasmService is configured as a built-in ``envoy.wasm_service`` :ref:`WasmService
// <config_wasm_service>` This opaque configuration will be used to create a Wasm Service.
#WasmService: {
	"@type": "type.googleapis.com/envoy.extensions.wasm.v3.WasmService"
	// General plugin configuration.
	config?: #PluginConfig
	// If true, create a single VM rather than creating one VM per worker. Such a singleton can
	// not be used with filters.
	singleton?: bool
}
