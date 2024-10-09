package v3

// TapSinkServiceClient is the client API for TapSinkService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#TapSinkServiceClient: _

#TapSinkService_StreamTapsClient: _

// TapSinkServiceServer is the server API for TapSinkService service.
// All implementations should embed UnimplementedTapSinkServiceServer
// for forward compatibility
#TapSinkServiceServer: _

// UnimplementedTapSinkServiceServer should be embedded to have forward compatible implementations.
#UnimplementedTapSinkServiceServer: {
	"@type": "type.googleapis.com/envoy.service.tap.v3.UnimplementedTapSinkServiceServer"
}

// UnsafeTapSinkServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to TapSinkServiceServer will
// result in compilation errors.
#UnsafeTapSinkServiceServer: _

#TapSinkService_StreamTapsServer: _
