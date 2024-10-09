package v3

#ServerNameMatcher: {
	"@type": "type.googleapis.com/github.com.cncf.xds.go.xds.type.matcher.v3.ServerNameMatcher"
	domain_matchers?: [...#ServerNameMatcher_DomainMatcher]
}

#ServerNameMatcher_DomainMatcher: {
	"@type": "type.googleapis.com/github.com.cncf.xds.go.xds.type.matcher.v3.ServerNameMatcher_DomainMatcher"
	domains?: [...string]
	on_match?: #Matcher_OnMatch
}
