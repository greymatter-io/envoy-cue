package v3

#ResourceLocator_Scheme: "XDSTP" | "HTTP" | "FILE"

ResourceLocator_Scheme_XDSTP: "XDSTP"
ResourceLocator_Scheme_HTTP:  "HTTP"
ResourceLocator_Scheme_FILE:  "FILE"

#ResourceLocator: {
	"@type":        "type.googleapis.com/github.com.cncf.xds.go.xds.core.v3.ResourceLocator"
	scheme?:        #ResourceLocator_Scheme
	id?:            string
	authority?:     string
	resource_type?: string
	exact_context?: #ContextParams
	directives?: [...#ResourceLocator_Directive]
}

#ResourceLocator_Directive: {
	"@type": "type.googleapis.com/github.com.cncf.xds.go.xds.core.v3.ResourceLocator_Directive"
	alt?:    #ResourceLocator
	entry?:  string
}
