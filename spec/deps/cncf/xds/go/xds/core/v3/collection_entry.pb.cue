package v3

#CollectionEntry: {
	"@type":       "type.googleapis.com/github.com.cncf.xds.go.xds.core.v3.CollectionEntry"
	locator?:      #ResourceLocator
	inline_entry?: #CollectionEntry_InlineEntry
}

#CollectionEntry_InlineEntry: {
	"@type":   "type.googleapis.com/github.com.cncf.xds.go.xds.core.v3.CollectionEntry_InlineEntry"
	name?:     string
	version?:  string
	resource?: _
}
