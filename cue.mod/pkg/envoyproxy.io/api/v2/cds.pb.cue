package v2

// [#not-implemented-hide:] Not configuration. Workaround c++ protobuf issue with importing
// services: https://github.com/google/protobuf/issues/4221 and protoxform to upgrade the file.
#CdsDummy: {
	"@type": "type.googleapis.com/envoy.api.v2.CdsDummy"
}

// ClusterDiscoveryServiceClient is the client API for ClusterDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#ClusterDiscoveryServiceClient: _

#ClusterDiscoveryService_StreamClustersClient: _

#ClusterDiscoveryService_DeltaClustersClient: _

// ClusterDiscoveryServiceServer is the server API for ClusterDiscoveryService service.
#ClusterDiscoveryServiceServer: _

// UnimplementedClusterDiscoveryServiceServer can be embedded to have forward compatible implementations.
#UnimplementedClusterDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.api.v2.UnimplementedClusterDiscoveryServiceServer"
}

#ClusterDiscoveryService_StreamClustersServer: _

#ClusterDiscoveryService_DeltaClustersServer: _
