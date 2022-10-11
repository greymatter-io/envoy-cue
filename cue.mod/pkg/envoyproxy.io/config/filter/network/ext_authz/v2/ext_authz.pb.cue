package v2

import (
	core "envoyproxy.io/api/v2/core"
)

// External Authorization filter calls out to an external service over the
// gRPC Authorization API defined by
// :ref:`CheckRequest <envoy_api_msg_service.auth.v2.CheckRequest>`.
// A failed check will cause this filter to close the TCP connection.
#ExtAuthz: {
	"@type": "type.googleapis.com/envoy.config.filter.network.ext_authz.v2.ExtAuthz"
	// The prefix to use when emitting statistics.
	stat_prefix?: string
	// The external authorization gRPC service configuration.
	// The default timeout is set to 200ms by this filter.
	grpc_service?: core.#GrpcService
	// The filter's behaviour in case the external authorization service does
	// not respond back. When it is set to true, Envoy will also allow traffic in case of
	// communication failure between authorization service and the proxy.
	// Defaults to false.
	failure_mode_allow?: bool
	// Specifies if the peer certificate is sent to the external service.
	//
	// When this field is true, Envoy will include the peer X.509 certificate, if available, in the
	// :ref:`certificate<envoy_api_field_service.auth.v2.AttributeContext.Peer.certificate>`.
	include_peer_certificate?: bool
}
