package matcher

// Specifies the way to match a Node.
// The match follows AND semantics.
#NodeMatcher: {
	"@type": "type.googleapis.com/envoy.type.matcher.NodeMatcher"
	// Specifies match criteria on the node id.
	node_id?: #StringMatcher
	// Specifies match criteria on the node metadata.
	node_metadatas?: [...#StructMatcher]
}
