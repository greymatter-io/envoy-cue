package v3

// Dumps of unready targets of envoy init managers. Envoy's admin fills this message with init managers,
// which provides the information of their unready targets.
// The :ref:`/init_dump <operations_admin_interface_init_dump>` will dump all unready targets information.
#UnreadyTargetsDumps: {
	"@type": "type.googleapis.com/envoy.admin.v3.UnreadyTargetsDumps"
	// You can choose specific component to dump unready targets with mask query parameter.
	// See :ref:`/init_dump?mask={} <operations_admin_interface_init_dump_by_mask>` for more information.
	// The dumps of unready targets of all init managers.
	unready_targets_dumps?: [...#UnreadyTargetsDumps_UnreadyTargetsDump]
}

// Message of unready targets information of an init manager.
#UnreadyTargetsDumps_UnreadyTargetsDump: {
	"@type": "type.googleapis.com/envoy.admin.v3.UnreadyTargetsDumps_UnreadyTargetsDump"
	// Name of the init manager. Example: "init_manager_xxx".
	name?: string
	// Names of unready targets of the init manager. Example: "target_xxx".
	target_names?: [...string]
}
