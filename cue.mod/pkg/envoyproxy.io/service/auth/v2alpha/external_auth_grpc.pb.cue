package v2alpha

// AuthorizationClient is the client API for Authorization service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#AuthorizationClient: _

// AuthorizationServer is the server API for Authorization service.
// All implementations should embed UnimplementedAuthorizationServer
// for forward compatibility
#AuthorizationServer: _

// UnimplementedAuthorizationServer should be embedded to have forward compatible implementations.
#UnimplementedAuthorizationServer: {
	"@type": "type.googleapis.com/envoy.service.auth.v2alpha.UnimplementedAuthorizationServer"
}

// UnsafeAuthorizationServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to AuthorizationServer will
// result in compilation errors.
#UnsafeAuthorizationServer: _
