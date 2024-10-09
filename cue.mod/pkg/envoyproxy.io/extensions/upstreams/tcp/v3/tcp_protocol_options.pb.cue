package v3

import (
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
)

#TcpProtocolOptions: {
	"@type": "type.googleapis.com/envoy.extensions.upstreams.tcp.v3.TcpProtocolOptions"
	// The idle timeout for the connection. The idle timeout is defined as the period in which
	// the connection is not associated with a downstream connection. When the idle timeout is
	// reached, the connection will be closed.
	//
	// If not set, the default idle timeout is 10 minutes. To disable idle timeouts, explicitly set this to 0.
	//
	// .. warning::
	//
	//	Disabling this timeout has a highly likelihood of yielding connection leaks due to lost TCP
	//	FIN packets, etc.
	idle_timeout?: durationpb.#Duration
}
