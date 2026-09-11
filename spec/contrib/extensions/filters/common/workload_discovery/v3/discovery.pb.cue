package v3

// NetworkMode indicates how the addresses of the workload should be treated.
#NetworkMode: "STANDARD" | "HOST_NETWORK"

NetworkMode_STANDARD:     "STANDARD"
NetworkMode_HOST_NETWORK: "HOST_NETWORK"

#WorkloadStatus: "HEALTHY" | "UNHEALTHY"

WorkloadStatus_HEALTHY:   "HEALTHY"
WorkloadStatus_UNHEALTHY: "UNHEALTHY"

#WorkloadType: "DEPLOYMENT" | "CRONJOB" | "POD" | "JOB"

WorkloadType_DEPLOYMENT: "DEPLOYMENT"
WorkloadType_CRONJOB:    "CRONJOB"
WorkloadType_POD:        "POD"
WorkloadType_JOB:        "JOB"

// TunnelProtocol indicates the tunneling protocol for requests.
#TunnelProtocol: "NONE" | "HBONE"

TunnelProtocol_NONE:  "NONE"
TunnelProtocol_HBONE: "HBONE"

#ApplicationTunnel_Protocol: "NONE" | "PROXY"

ApplicationTunnel_Protocol_NONE:  "NONE"
ApplicationTunnel_Protocol_PROXY: "PROXY"

// Workload represents a workload - an endpoint (or collection behind a hostname).
// The xds primary key is "uid" as defined on the workload below.
// Secondary (alias) keys are the unique “network/IP“ pairs that the workload can be reached at.
// [#next-free-field: 26]
#Workload: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.workload_discovery.v3.Workload"
	// UID represents a globally unique opaque identifier for this workload.
	// For k8s resources, it is recommended to use the more readable format:
	//
	// cluster/group/kind/namespace/name/section-name
	//
	// As an example, a ServiceEntry with two WorkloadEntries inlined could become
	// two Workloads with the following UIDs:
	// - cluster1/networking.istio.io/v1alpha3/ServiceEntry/default/external-svc/endpoint1
	// - cluster1/networking.istio.io/v1alpha3/ServiceEntry/default/external-svc/endpoint2
	//
	// For VMs and other workloads other formats are also supported; for example,
	// a single UID string: "0ae5c03d-5fb3-4eb9-9de8-2bd4b51606ba"
	uid?: string
	// Name represents the name for the workload.
	// For Kubernetes, this is the pod name.
	// This is just for debugging and may be elided as an optimization.
	name?: string
	// Namespace represents the namespace for the workload.
	// This is just for debugging and may be elided as an optimization.
	namespace?: string
	// Address represents the IPv4/IPv6 address for the workload.
	// This should be globally unique.
	// This should not have a port number.
	// Each workload must have at least either an address or hostname; not both.
	addresses?: [...bytes]
	// The hostname for the workload to be resolved by the ztunnel.
	// DNS queries are sent on-demand by default.
	// If the resolved DNS query has several endpoints, the request will be forwarded
	// to the first response.
	//
	// At a minimum, each workload must have either an address or hostname. For example,
	// a workload that backs a Kubernetes service will typically have only endpoints. A
	// workload that backs a headless Kubernetes service, however, will have both
	// addresses as well as a hostname used for direct access to the headless endpoint.
	hostname?: string
	// Network represents the network this workload is on. This may be elided for the default network.
	// A (network,address) pair makeup a unique key for a workload *at a point in time*.
	network?: string
	// Protocol that should be used to connect to this workload.
	tunnel_protocol?: #TunnelProtocol
	// The SPIFFE identity of the workload. The identity is joined to form spiffe://<trust_domain>/ns/<namespace>/sa/<service_account>.
	// TrustDomain of the workload. May be elided if this is the mesh wide default (typically cluster.local)
	trust_domain?: string
	// ServiceAccount of the workload. May be elided if this is "default"
	service_account?: string
	// If present, the waypoint proxy for this workload.
	// All incoming requests must go through the waypoint.
	waypoint?: #GatewayAddress
	// If present, East West network gateway this workload can be reached through.
	// Requests from remote networks should traverse this gateway.
	network_gateway?: #GatewayAddress
	// Name of the node the workload runs on
	node?: string
	// CanonicalName for the workload. Used for telemetry.
	canonical_name?: string
	// CanonicalRevision for the workload. Used for telemetry.
	canonical_revision?: string
	// WorkloadType represents the type of the workload. Used for telemetry.
	workload_type?: #WorkloadType
	// WorkloadName represents the name for the workload (of type WorkloadType). Used for telemetry.
	workload_name?: string
	// If set, this indicates a workload expects to directly receive tunnel traffic.
	// In ztunnel, this means:
	// * Requests *from* this workload do not need to be tunneled if they already are tunneled by the tunnel_protocol.
	// * Requests *to* this workload, via the tunnel_protocol, do not need to be de-tunneled.
	native_tunnel?: bool
	// If an application, such as a sandwiched waypoint proxy, supports directly
	// receiving information from zTunnel they can set application_protocol.
	application_tunnel?: #ApplicationTunnel
	// The services for which this workload is an endpoint.
	// The key is the NamespacedHostname string of the format namespace/hostname.
	services?: [string]: #PortList
	// A list of authorization policies applicable to this workload.
	// NOTE: this *only* includes Selector based policies. Namespace and global polices
	// are returned out of band.
	// Authorization policies are only valid for workloads with “addresses“ rather than “hostname“.
	authorization_policies?: [...string]
	status?: #WorkloadStatus
	// The cluster ID that the workload instance belongs to
	cluster_id?: string
	// The Locality defines information about where a workload is geographically deployed
	locality?:     #Locality
	network_mode?: #NetworkMode
}

#Locality: {
	"@type":  "type.googleapis.com/envoy.extensions.filters.common.workload_discovery.v3.Locality"
	region?:  string
	zone?:    string
	subzone?: string
}

// This represents the ports for a service
#PortList: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.workload_discovery.v3.PortList"
	ports?: [...#Port]
}

#Port: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.workload_discovery.v3.Port"
	// Port the service is reached at (frontend).
	service_port?: uint32
	// Port the service forwards to (backend).
	target_port?: uint32
}

// ApplicationProtocol specifies a workload  (application or gateway) can
// consume tunnel information.
#ApplicationTunnel: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.workload_discovery.v3.ApplicationTunnel"
	// A target natively handles this type of traffic.
	protocol?: #ApplicationTunnel_Protocol
	// optional: if set, traffic should be sent to this port after the last zTunnel hop
	port?: uint32
}

// GatewayAddress represents the address of a gateway
#GatewayAddress: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.workload_discovery.v3.GatewayAddress"
	// TODO: add support for hostname lookup
	hostname?: #NamespacedHostname
	address?:  #NetworkAddress
	// port to reach the gateway at for mTLS HBONE connections
	hbone_mtls_port?: uint32
}

// NetworkAddress represents an address bound to a specific network.
#NetworkAddress: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.workload_discovery.v3.NetworkAddress"
	// Network represents the network this address is on.
	network?: string
	// Address presents the IP (v4 or v6).
	address?: bytes
}

// NamespacedHostname represents a service bound to a specific namespace.
#NamespacedHostname: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.workload_discovery.v3.NamespacedHostname"
	// The namespace the service is in.
	namespace?: string
	// hostname (ex: gateway.example.com)
	hostname?: string
}
