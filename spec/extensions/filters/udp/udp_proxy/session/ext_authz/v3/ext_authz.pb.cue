package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// External authorization for UDP proxy sessions over the gRPC
// :ref:`CheckRequest <envoy_v3_api_msg_service.auth.v3.CheckRequest>` API.
#FilterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.udp_proxy.session.ext_authz.v3.FilterConfig"
	// The prefix to use when emitting :ref:`statistics
	// <config_udp_session_filters_ext_authz_stats>`.
	stat_prefix?: string
	// The external authorization gRPC service configuration (default timeout: 200ms).
	grpc_service?: v3.#GrpcService
	// The filter's behaviour in case the external authorization service does not respond back, or
	// when it returns an error. When set to true, the new session is established and traffic is
	// forwarded to the upstream. When set to false, the session is dropped. Defaults to false.
	failure_mode_allow?: bool
	// If configured, the filter will buffer datagrams while it is waiting for the authorization
	// response. If this field is not configured, there will be no buffering and downstream datagrams
	// that arrive while the authorization call is in progress will be dropped. In case this field is
	// set but the options are not configured, the default values will be applied as described in the
	// “BufferOptions“.
	buffer_options?: #FilterConfig_BufferOptions
}

// Configuration for UDP datagrams buffering while the authorization call is in flight.
#FilterConfig_BufferOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.udp_proxy.session.ext_authz.v3.FilterConfig_BufferOptions"
	// If set, the filter will only buffer datagrams up to the requested limit, and will drop
	// new UDP datagrams if the buffer contains the max_buffered_datagrams value at the time
	// of a new datagram arrival. If not set, the default value is 1024 datagrams.
	max_buffered_datagrams?: uint32
	// If set, the filter will only buffer datagrams up to the requested total buffered bytes limit,
	// and will drop new UDP datagrams if the buffer contains the max_buffered_bytes value
	// at the time of a new datagram arrival. If not set, the default value is 16,384 (16KB).
	max_buffered_bytes?: uint64
}
