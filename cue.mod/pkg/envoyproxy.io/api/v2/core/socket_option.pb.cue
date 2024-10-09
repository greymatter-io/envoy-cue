package core

#SocketOption_SocketState: "STATE_PREBIND" | "STATE_BOUND" | "STATE_LISTENING"

SocketOption_SocketState_STATE_PREBIND:   "STATE_PREBIND"
SocketOption_SocketState_STATE_BOUND:     "STATE_BOUND"
SocketOption_SocketState_STATE_LISTENING: "STATE_LISTENING"

// Generic socket option message. This would be used to set socket options that
// might not exist in upstream kernels or precompiled Envoy binaries.
// [#next-free-field: 7]
#SocketOption: {
	"@type": "type.googleapis.com/envoy.api.v2.core.SocketOption"
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
