package v2

// ClusterDiscoveryServiceClient is the client API for ClusterDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#ClusterDiscoveryServiceClient: _

#ClusterDiscoveryService_StreamClustersClient: _

#ClusterDiscoveryService_DeltaClustersClient: _

// ClusterDiscoveryServiceServer is the server API for ClusterDiscoveryService service.
// All implementations should embed UnimplementedClusterDiscoveryServiceServer
// for forward compatibility
#ClusterDiscoveryServiceServer: _

// UnimplementedClusterDiscoveryServiceServer should be embedded to have forward compatible implementations.
#UnimplementedClusterDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.api.v2.UnimplementedClusterDiscoveryServiceServer"
}

// UnsafeClusterDiscoveryServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to ClusterDiscoveryServiceServer will
// result in compilation errors.
#UnsafeClusterDiscoveryServiceServer: _

#ClusterDiscoveryService_StreamClustersServer: _

#ClusterDiscoveryService_DeltaClustersServer: _
