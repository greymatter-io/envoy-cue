package v2

// RateLimitServiceClient is the client API for RateLimitService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#RateLimitServiceClient: _

// RateLimitServiceServer is the server API for RateLimitService service.
// All implementations should embed UnimplementedRateLimitServiceServer
// for forward compatibility
#RateLimitServiceServer: _

// UnimplementedRateLimitServiceServer should be embedded to have forward compatible implementations.
#UnimplementedRateLimitServiceServer: {
	"@type": "type.googleapis.com/envoy.service.ratelimit.v2.UnimplementedRateLimitServiceServer"
}

// UnsafeRateLimitServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to RateLimitServiceServer will
// result in compilation errors.
#UnsafeRateLimitServiceServer: _
