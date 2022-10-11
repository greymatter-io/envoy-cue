package v3

import (
	v3 "envoyproxy.io/config/core/v3"
	v31 "envoyproxy.io/config/common/mutation_rules/v3"
)

// [#next-free-field: 10]
#ExternalProcessor: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_proc.v3.ExternalProcessor"
	// Configuration for the gRPC service that the filter will communicate with.
	// The filter supports both the "Envoy" and "Google" gRPC clients.
	grpc_service?: v3.#GrpcService
	// By default, if the gRPC stream cannot be established, or if it is closed
	// prematurely with an error, the filter will fail. Specifically, if the
	// response headers have not yet been delivered, then it will return a 500
	// error downstream. If they have been delivered, then instead the HTTP stream to the
	// downstream client will be reset.
	// With this parameter set to true, however, then if the gRPC stream is prematurely closed
	// or could not be opened, processing continues without error.
	failure_mode_allow?: bool
	// Specifies default options for how HTTP headers, trailers, and bodies are
	// sent. See ProcessingMode for details.
	processing_mode?: #ProcessingMode
	// [#not-implemented-hide:]
	// If true, send each part of the HTTP request or response specified by ProcessingMode
	// asynchronously -- in other words, send the message on the gRPC stream and then continue
	// filter processing. If false, which is the default, suspend filter execution after
	// each message is sent to the remote service and wait up to "message_timeout"
	// for a reply.
	async_mode?: bool
	// [#not-implemented-hide:]
	// Envoy provides a number of :ref:`attributes <arch_overview_attributes>`
	// for expressive policies. Each attribute name provided in this field will be
	// matched against that list and populated in the request_headers message.
	// See the :ref:`attribute documentation <arch_overview_request_attributes>`
	// for the list of supported attributes and their types.
	request_attributes?: [...string]
	// [#not-implemented-hide:]
	// Envoy provides a number of :ref:`attributes <arch_overview_attributes>`
	// for expressive policies. Each attribute name provided in this field will be
	// matched against that list and populated in the response_headers message.
	// See the :ref:`attribute documentation <arch_overview_attributes>`
	// for the list of supported attributes and their types.
	response_attributes?: [...string]
	// Specifies the timeout for each individual message sent on the stream and
	// when the filter is running in synchronous mode. Whenever
	// the proxy sends a message on the stream that requires a response, it will
	// reset this timer, and will stop processing and return an error (subject
	// to the processing mode) if the timer expires before a matching response.
	// is received. There is no timeout when the filter is running in asynchronous
	// mode. Default is 200 milliseconds.
	message_timeout?: string
	// Optional additional prefix to use when emitting statistics. This allows to distinguish
	// emitted statistics between configured *ext_proc* filters in an HTTP filter chain.
	stat_prefix?: string
	// Rules that determine what modifications an external processing server may
	// make to message headers. If not set, all headers may be modified except
	// for "host", ":authority", ":scheme", ":method", and headers that start
	// with the header prefix set via
	// :ref:`header_prefix <envoy_v3_api_field_config.bootstrap.v3.Bootstrap.header_prefix>`
	// (which is usually "x-envoy").
	mutation_rules?: v31.#HeaderMutationRules
}

// Extra settings that may be added to per-route configuration for a
// virtual host or cluster.
#ExtProcPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_proc.v3.ExtProcPerRoute"
	// Disable the filter for this particular vhost or route.
	// If disabled is specified in multiple per-filter-configs, the most specific one will be used.
	disabled?: bool
	// Override aspects of the configuration for this route. A set of
	// overrides in a more specific configuration will override a "disabled"
	// flag set in a less-specific one.
	overrides?: #ExtProcOverrides
}

// Overrides that may be set on a per-route basis
// [#next-free-field: 6]
#ExtProcOverrides: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_proc.v3.ExtProcOverrides"
	// Set a different processing mode for this route than the default.
	processing_mode?: #ProcessingMode
	// [#not-implemented-hide:]
	// Set a different asynchronous processing option than the default.
	async_mode?: bool
	// [#not-implemented-hide:]
	// Set different optional attributes than the default setting of the
	// ``request_attributes`` field.
	request_attributes?: [...string]
	// [#not-implemented-hide:]
	// Set different optional properties than the default setting of the
	// ``response_attributes`` field.
	response_attributes?: [...string]
	// Set a different gRPC service for this route than the default.
	grpc_service?: v3.#GrpcService
}
