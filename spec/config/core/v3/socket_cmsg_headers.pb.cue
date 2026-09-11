package v3

// Configuration for socket cmsg headers.
// See `:ref:CMSG <https://man7.org/linux/man-pages/man3/cmsg.3.html>`_ for further information.
#SocketCmsgHeaders: {
	"@type": "type.googleapis.com/envoy.config.core.v3.SocketCmsgHeaders"
	// cmsg level. Default is unset.
	level?: uint32
	// cmsg type. Default is unset.
	type?: uint32
	// Expected size of cmsg value. Default is zero.
	expected_size?: uint32
}
