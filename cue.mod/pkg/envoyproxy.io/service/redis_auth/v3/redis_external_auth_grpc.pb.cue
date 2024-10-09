package v3

// RedisProxyExternalAuthClient is the client API for RedisProxyExternalAuth service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#RedisProxyExternalAuthClient: _

// RedisProxyExternalAuthServer is the server API for RedisProxyExternalAuth service.
// All implementations should embed UnimplementedRedisProxyExternalAuthServer
// for forward compatibility
#RedisProxyExternalAuthServer: _

// UnimplementedRedisProxyExternalAuthServer should be embedded to have forward compatible implementations.
#UnimplementedRedisProxyExternalAuthServer: {
	"@type": "type.googleapis.com/envoy.service.redis_auth.v3.UnimplementedRedisProxyExternalAuthServer"
}

// UnsafeRedisProxyExternalAuthServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to RedisProxyExternalAuthServer will
// result in compilation errors.
#UnsafeRedisProxyExternalAuthServer: _
