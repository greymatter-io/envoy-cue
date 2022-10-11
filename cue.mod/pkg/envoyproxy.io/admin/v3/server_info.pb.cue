package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

#ServerInfo_State: "LIVE" | "DRAINING" | "PRE_INITIALIZING" | "INITIALIZING"

ServerInfo_State_LIVE:             "LIVE"
ServerInfo_State_DRAINING:         "DRAINING"
ServerInfo_State_PRE_INITIALIZING: "PRE_INITIALIZING"
ServerInfo_State_INITIALIZING:     "INITIALIZING"

#CommandLineOptions_IpVersion: "v4" | "v6"

CommandLineOptions_IpVersion_v4: "v4"
CommandLineOptions_IpVersion_v6: "v6"

#CommandLineOptions_Mode: "Serve" | "Validate" | "InitOnly"

CommandLineOptions_Mode_Serve:    "Serve"
CommandLineOptions_Mode_Validate: "Validate"
CommandLineOptions_Mode_InitOnly: "InitOnly"

#CommandLineOptions_DrainStrategy: "Gradual" | "Immediate"

CommandLineOptions_DrainStrategy_Gradual:   "Gradual"
CommandLineOptions_DrainStrategy_Immediate: "Immediate"

// Proto representation of the value returned by /server_info, containing
// server version/server status information.
// [#next-free-field: 8]
#ServerInfo: {
	"@type": "type.googleapis.com/envoy.admin.v3.ServerInfo"
	// Server version.
	version?: string
	// State of the server.
	state?: #ServerInfo_State
	// Uptime since current epoch was started.
	uptime_current_epoch?: string
	// Uptime since the start of the first epoch.
	uptime_all_epochs?: string
	// Hot restart version.
	hot_restart_version?: string
	// Command line options the server is currently running with.
	command_line_options?: #CommandLineOptions
	// Populated node identity of this server.
	node?: v3.#Node
}

// [#next-free-field: 39]
#CommandLineOptions: {
	"@type": "type.googleapis.com/envoy.admin.v3.CommandLineOptions"
	// See :option:`--base-id` for details.
	base_id?: uint64
	// See :option:`--use-dynamic-base-id` for details.
	use_dynamic_base_id?: bool
	// See :option:`--base-id-path` for details.
	base_id_path?: string
	// See :option:`--concurrency` for details.
	concurrency?: uint32
	// See :option:`--config-path` for details.
	config_path?: string
	// See :option:`--config-yaml` for details.
	config_yaml?: string
	// See :option:`--allow-unknown-static-fields` for details.
	allow_unknown_static_fields?: bool
	// See :option:`--reject-unknown-dynamic-fields` for details.
	reject_unknown_dynamic_fields?: bool
	// See :option:`--ignore-unknown-dynamic-fields` for details.
	ignore_unknown_dynamic_fields?: bool
	// See :option:`--admin-address-path` for details.
	admin_address_path?: string
	// See :option:`--local-address-ip-version` for details.
	local_address_ip_version?: #CommandLineOptions_IpVersion
	// See :option:`--log-level` for details.
	log_level?: string
	// See :option:`--component-log-level` for details.
	component_log_level?: string
	// See :option:`--log-format` for details.
	log_format?: string
	// See :option:`--log-format-escaped` for details.
	log_format_escaped?: bool
	// See :option:`--log-path` for details.
	log_path?: string
	// See :option:`--service-cluster` for details.
	service_cluster?: string
	// See :option:`--service-node` for details.
	service_node?: string
	// See :option:`--service-zone` for details.
	service_zone?: string
	// See :option:`--file-flush-interval-msec` for details.
	file_flush_interval?: string
	// See :option:`--drain-time-s` for details.
	drain_time?: string
	// See :option:`--drain-strategy` for details.
	drain_strategy?: #CommandLineOptions_DrainStrategy
	// See :option:`--parent-shutdown-time-s` for details.
	parent_shutdown_time?: string
	// See :option:`--mode` for details.
	mode?: #CommandLineOptions_Mode
	// See :option:`--disable-hot-restart` for details.
	disable_hot_restart?: bool
	// See :option:`--enable-mutex-tracing` for details.
	enable_mutex_tracing?: bool
	// See :option:`--restart-epoch` for details.
	restart_epoch?: uint32
	// See :option:`--cpuset-threads` for details.
	cpuset_threads?: bool
	// See :option:`--disable-extensions` for details.
	disabled_extensions?: [...string]
	// See :option:`--enable-fine-grain-logging` for details.
	enable_fine_grain_logging?: bool
	// See :option:`--socket-path` for details.
	socket_path?: string
	// See :option:`--socket-mode` for details.
	socket_mode?: uint32
	// See :option:`--enable-core-dump` for details.
	enable_core_dump?: bool
	// See :option:`--stats-tag` for details.
	stats_tag?: [...string]
}
