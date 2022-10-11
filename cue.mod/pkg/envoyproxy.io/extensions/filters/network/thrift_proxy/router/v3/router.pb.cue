package v3

#Router: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.router.v3.Router"
	// Close downstream connection in case of routing or upstream connection problem. Default: true
	close_downstream_on_upstream_error?: bool
}
