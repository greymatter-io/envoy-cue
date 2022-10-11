package v3

#StringMatcher: {
	"@type":      "type.googleapis.com/github.com.cncf.xds.go.xds.type.matcher.v3.StringMatcher"
	exact?:       string
	prefix?:      string
	suffix?:      string
	safe_regex?:  #RegexMatcher
	contains?:    string
	ignore_case?: bool
}

#ListStringMatcher: {
	"@type": "type.googleapis.com/github.com.cncf.xds.go.xds.type.matcher.v3.ListStringMatcher"
	patterns?: [...#StringMatcher]
}
