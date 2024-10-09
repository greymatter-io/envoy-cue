package v3

import (
	status "envoyproxy.io/deps/genproto/googleapis/rpc/status"
	timestamppb "envoyproxy.io/deps/protobuf/types/known/timestamppb"
)

#RedisProxyExternalAuthRequest: {
	"@type": "type.googleapis.com/envoy.service.redis_auth.v3.RedisProxyExternalAuthRequest"
	// Username, if applicable. Otherwise, empty.
	username?: string
	// Password sent with the AUTH command.
	password?: string
}

#RedisProxyExternalAuthResponse: {
	"@type": "type.googleapis.com/envoy.service.redis_auth.v3.RedisProxyExternalAuthResponse"
	// Status of the authentication check.
	status?: status.#Status
	// Optional expiration time for the authentication.
	// If set, the authentication will be valid until this time.
	// If not set, the authentication will be valid indefinitely.
	expiration?: timestamppb.#Timestamp
	// Optional message to be sent back to the client.
	message?: string
}
