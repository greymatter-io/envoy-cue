package v3

// RateLimitQuotaServiceClient is the client API for RateLimitQuotaService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#RateLimitQuotaServiceClient: _

#RateLimitQuotaService_StreamRateLimitQuotasClient: _

// RateLimitQuotaServiceServer is the server API for RateLimitQuotaService service.
// All implementations should embed UnimplementedRateLimitQuotaServiceServer
// for forward compatibility
#RateLimitQuotaServiceServer: _

// UnimplementedRateLimitQuotaServiceServer should be embedded to have forward compatible implementations.
#UnimplementedRateLimitQuotaServiceServer: {
	"@type": "type.googleapis.com/envoy.service.rate_limit_quota.v3.UnimplementedRateLimitQuotaServiceServer"
}

// UnsafeRateLimitQuotaServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to RateLimitQuotaServiceServer will
// result in compilation errors.
#UnsafeRateLimitQuotaServiceServer: _

#RateLimitQuotaService_StreamRateLimitQuotasServer: _
