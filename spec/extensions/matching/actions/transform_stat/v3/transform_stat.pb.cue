package v3

// Transform action for the stat matched by the tag.
#TransformStat: {
	"@type": "type.googleapis.com/envoy.extensions.matching.actions.transform_stat.v3.TransformStat"
	// If set, the stat will be dropped.
	drop_stat?: #TransformStat_DropStat
	// If set, the tag ill be dropped.
	// This removes the tag from the stat entirely.
	drop_tag?: #TransformStat_DropTag
	// If set, the tag will be updated.
	update_tag?: #TransformStat_UpdateTag
}

// Action that drops the stat.
#TransformStat_DropStat: {
	"@type": "type.googleapis.com/envoy.extensions.matching.actions.transform_stat.v3.TransformStat_DropStat"
}

// Action that drops the tag.
// This removes the tag from the stat entirely. This is different from updating the
// tag to an empty value, which keeps the tag key with an empty value.
#TransformStat_DropTag: {
	"@type": "type.googleapis.com/envoy.extensions.matching.actions.transform_stat.v3.TransformStat_DropTag"
}

// Action that updates the tag.
#TransformStat_UpdateTag: {
	"@type": "type.googleapis.com/envoy.extensions.matching.actions.transform_stat.v3.TransformStat_UpdateTag"
	// The new tag value.
	new_tag_value?: string
}
