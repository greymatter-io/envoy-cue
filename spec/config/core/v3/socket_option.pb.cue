package v3

#SocketOption_SocketState: "STATE_PREBIND" | "STATE_BOUND" | "STATE_LISTENING"

SocketOption_SocketState_STATE_PREBIND:   "STATE_PREBIND"
SocketOption_SocketState_STATE_BOUND:     "STATE_BOUND"
SocketOption_SocketState_STATE_LISTENING: "STATE_LISTENING"

// Generic socket option message. This would be used to set socket options that
// might not exist in upstream kernels or precompiled Envoy binaries.
//
// For example:
//
// .. code-block:: json
//
//  {
//    "description": "support tcp keep alive",
//    "state": 0,
//    "level": 1,
//    "name": 9,
//    "int_value": 1,
//  }
//
// 1 means SOL_SOCKET and 9 means SO_KEEPALIVE on Linux.
// With the above configuration, `TCP Keep-Alives <https://www.freesoft.org/CIE/RFC/1122/114.htm>`_
// can be enabled in socket with Linux, which can be used in
// :ref:`listener's<envoy_v3_api_field_config.listener.v3.Listener.socket_options>` or
// :ref:`admin's <envoy_v3_api_field_config.bootstrap.v3.Admin.socket_options>` socket_options etc.
//
// It should be noted that the name or level may have different values on different platforms.
// [#next-free-field: 7]
#SocketOption: {
	"@type": "type.googleapis.com/envoy.config.core.v3.SocketOption"
	// An optional name to give this socket option for debugging, etc.
	// Uniqueness is not required and no special meaning is assumed.
	description?: string
	// Corresponding to the level value passed to setsockopt, such as IPPROTO_TCP
	level?: int64
	// The numeric name as passed to setsockopt
	name?: int64
	// Because many sockopts take an int value.
	int_value?: int64
	// Otherwise it's a byte buffer.
	buf_value?: bytes
	// The state in which the option will be applied. When used in BindConfig
	// STATE_PREBIND is currently the only valid value.
	state?: #SocketOption_SocketState
}

// [#not-implemented-hide:]
#SocketOptionsOverride: {
	"@type": "type.googleapis.com/envoy.config.core.v3.SocketOptionsOverride"
	socket_options?: [...#SocketOption]
}
